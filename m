Return-Path: <SRS0=We5Z=IL=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZrQI6fP7ddJjJrjffqNyc3VZN554swzcQbQipyV5PO8gbSmd/HEcZOHREzctZftvoiCRmsB
ARC-Seal: i=1; a=rsa-sha256; t=1527156327; cv=none;
        d=google.com; s=arc-20160816;
        b=gVjR1CDOyTgH2eOxIOeSL9gqp1LTTrCh6onAR2NV7LWid/QVUHeut13ECQng2yA8NC
         v4KT4gc/SUzLHfOqYJT9vzZUUhBP6fJtwth10pTb0A5IyRu17OmkgFNbMnKfYTwtetP/
         YTKASo2g98Y2rwOM8ROZCHdspv9AOZX1T1dO+g3cxFnBuPoO9ewahglNYH6Jq0ifeus/
         JcXJFOvEZcNQkhdX9qcYgWK5iBOKXS8iZKm7zW3ZZXTctQw8svGB6B9v7q9Rk/ynDyRN
         PN98uFKwNKtwsYk+ioT6IfBmXBcr4sApo3SGNiQtlEq9Szg43OWOtHdQ2pg2lbchFWIG
         rdOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dkim-signature:arc-authentication-results;
        bh=ruLEZ2CANCsjLvFGK+ke6yB4GVV04iT0gcSZrb7FctI=;
        b=Y9zjBwaB+WP17WIm9qSQiF2U7VGp7I+Suol9qw8sVr++VerQwwu6htbkFLBIBXhwLN
         gWla2AMnPrL317Z8h9mOAG9pvzetI11CinjjLq7iZ7tV4CddGVP3/foN8tXrTHESeZWe
         RcxY1hH6eeFX4O25frfx9U0mE+xG0AMEn/5C1uW4xBYd3POhv23WXsles4mZrQE6OfLd
         pmO6EU0pAhN5YVGJCvO+xX87CiawBhIlx5OBj4OItiGqzxqPIi5F5mKrttXjQQv2LsBg
         TtC9PltuX1VCv9TYqPAUA4y5bVt/wTfaAhAPpUpIxRixKnTsiGHqfjPzhmbv/INq9UiB
         OUTQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=BapAV3Im;
       spf=pass (google.com: domain of srs0=we5z=il=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=We5Z=IL=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=BapAV3Im;
       spf=pass (google.com: domain of srs0=we5z=il=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=We5Z=IL=linuxfoundation.org=gregkh@kernel.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.16 147/161] serial: sh-sci: Fix out-of-bounds access through DT alias
Date: Thu, 24 May 2018 11:39:32 +0200
Message-Id: <20180524093035.922789778@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180524093018.331893860@linuxfoundation.org>
References: <20180524093018.331893860@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1601339026644311877?=
X-GMAIL-MSGID: =?utf-8?q?1601339472768688463?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.16-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Geert Uytterhoeven <geert+renesas@glider.be>

[ Upstream commit 090fa4b0dccfa3d04e1c5ab0fe4eba16e6713895 ]

The sci_ports[] array is indexed using a value derived from the
"serialN" alias in DT, which may lead to an out-of-bounds access.

Fix this by adding a range check.

Note that the array size is defined by a Kconfig symbol
(CONFIG_SERIAL_SH_SCI_NR_UARTS), so this can even be triggered using a
legitimate DTB.

Fixes: 97ed9790c514066b ("serial: sh-sci: Remove unused platform data capabilities field")
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/tty/serial/sh-sci.c |    4 ++++
 1 file changed, 4 insertions(+)

--- a/drivers/tty/serial/sh-sci.c
+++ b/drivers/tty/serial/sh-sci.c
@@ -3098,6 +3098,10 @@ static struct plat_sci_port *sci_parse_d
 		dev_err(&pdev->dev, "failed to get alias id (%d)\n", id);
 		return NULL;
 	}
+	if (id >= ARRAY_SIZE(sci_ports)) {
+		dev_err(&pdev->dev, "serial%d out of range\n", id);
+		return NULL;
+	}
 
 	sp = &sci_ports[id];
 	*dev_id = id;
