Return-Path: <SRS0=We5Z=IL=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZr/clqdA/qc/xfDzNkOqy2gnfZTGAFHFfFEWai82MK0gSvUtYHUtz+nMR/cqmdxZkjTCnnL
ARC-Seal: i=1; a=rsa-sha256; t=1527156332; cv=none;
        d=google.com; s=arc-20160816;
        b=wo+TtnwHR2p1aWbuFTE88g0F1tdIZ3CJl+14msgkknlPRZ9TfAeeC3/s6p4ILXvhpc
         urOZyVUjEx2bxRgtwkk3sa6Nv0G0abq/wyigbu6aKW17zDLRMdF7R2Oee/XKWm5rsQyU
         70LiFiryCetUuY7ePqib6G2vNAG3hq5urCO3q85ndcoukTje2BXwHqRsib/l88z9f/Wx
         wdWwes+ewC+hJjV/l+tAYLEYX0wJywYUbqy3aleYplzIOXeUWVc9j4VuvCR4W5OzXQFT
         smxT00QkWnqUqLkJaHSEdSVDRB6kOGoJpqR5Rl006ofq0AuZ9mYNxMF95NqAD0QSuAsc
         Lt+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dkim-signature:arc-authentication-results;
        bh=eI1s48287F1Hq7axbIkfWUInb4NMrQ2NVmxQnduebeA=;
        b=aVFqA0HgK4gwjo3D4U7+ux0zSYZl8ckbjLmwGuHOfV8Kq21boaikB8SJTUosLy83aJ
         BDIILamN2NjQkrIVe25EOkkiTGXYYkgK8N23XIXJc/3HnlfvFwRFTdzWCyRQi9b5iPqk
         7XeB1icOWkVbVNJl+kqbyd/BTKCjlny565rR0TcP2HMHmzyntgQK/0h2yM4HydSbvVZp
         r/wqWLDbgQth6ZZFvQVcfNRxfcTDJi49FeMmEAd5v+GdFBX+ls92Z7Vk/8qgGB3kOCg6
         c5ni7WB31AlJ13moLqz8BVAHXprT5+z1mB0uS6PsfQlnF/Ydi2kfrPjVaG5yeInYvw8l
         FsRw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=Wnv+Yqac;
       spf=pass (google.com: domain of srs0=we5z=il=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=We5Z=IL=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=Wnv+Yqac;
       spf=pass (google.com: domain of srs0=we5z=il=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=We5Z=IL=linuxfoundation.org=gregkh@kernel.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.16 149/161] serial: mxs-auart: Fix out-of-bounds access through serial port index
Date: Thu, 24 May 2018 11:39:34 +0200
Message-Id: <20180524093036.172129953@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180524093018.331893860@linuxfoundation.org>
References: <20180524093018.331893860@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1601338555657569528?=
X-GMAIL-MSGID: =?utf-8?q?1601339478837646060?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.16-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Geert Uytterhoeven <geert+renesas@glider.be>

[ Upstream commit dd345a31bfdec350d2593e6de5964e55c7f19c76 ]

The auart_port[] array is indexed using a value derived from the
"serialN" alias in DT, or from platform data, which may lead to an
out-of-bounds access.

Fix this by adding a range check.

Fixes: 1ea6607d4cdc9179 ("serial: mxs-auart: Allow device tree probing")
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/tty/serial/mxs-auart.c |    4 ++++
 1 file changed, 4 insertions(+)

--- a/drivers/tty/serial/mxs-auart.c
+++ b/drivers/tty/serial/mxs-auart.c
@@ -1663,6 +1663,10 @@ static int mxs_auart_probe(struct platfo
 		s->port.line = pdev->id < 0 ? 0 : pdev->id;
 	else if (ret < 0)
 		return ret;
+	if (s->port.line >= ARRAY_SIZE(auart_port)) {
+		dev_err(&pdev->dev, "serial%d out of range\n", s->port.line);
+		return -EINVAL;
+	}
 
 	if (of_id) {
 		pdev->id_entry = of_id->data;
