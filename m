Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx4/KL/Sz9vmWlwqn8W+xPGjwuCcnZrJlWqLxUIWNNyCb5aibh6I7BiJDADjFex8WnZgkETeo
ARC-Seal: i=1; a=rsa-sha256; t=1524406303; cv=none;
        d=google.com; s=arc-20160816;
        b=nsbO2RzAA3TvsVy4T8W7jyhY2paneMDadH78+d/4SgsBhPoCIhZ5SoxnEkz0y08Vek
         Pda5tvszWlZO1s9CimRJ6o/s2suH66GKfsfFrCtX+FsOpaH1N/vSRGljhcP6kmr4IBUt
         OXBS7+QPEztQT3DJzRAgBq+8LnkCVpCKUzHZ6rFDg1XGYxuZfrZF3XlO1/209eAltiWN
         whFbnj0nh3AXW+PkbX6aVi9rXpW2gQR71TAkyFMN1vCNVrIXa8HPq6HJFrtNupoPjHTU
         nvWdcbpItViAzo9oT9sy5UZ6GA3FY/Rt5L9HBnMX8LQWHDKitR4ldFPPwdtKLtMQElXt
         88Bg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=SJnV6uSeWLxKZeCesL0LdvBSR89qgy2XIwhNPtiTfUo=;
        b=FHGq1JQymrFwj3ysisIV75ua1lOxXgLwRL9Lq4NsItcxmfjkkAz65ZBCLgcW0b4q6Q
         wi4w6zN3CmpKMqY9mzba9JafdHsmaVWoMq/rU3dmp3kzIZn7e2k7VJb3bnHvNNq7EVpG
         8/Pl1a4ShEQYQXVurNlplWVRrvxIymZCA9ju3sbZbx6KZLVR2ApNnh3vkYLL9l0S1xEk
         PMFwjHfgfo7mQCXa7KT011p9osmPd6APOeH9bcU5QppESgu8U9bua9B3Gady2/3dZ1A9
         demw/esTmkCm6TeNanDNOrDYe6PAoo5NDfId6Z1pKXuw/onDTLo2sqJB15OLirGHPgjx
         GMMg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Martin Townsend <mtownsend1973@gmail.com>,
	Richard Weinberger <richard@nod.at>
Subject: [PATCH 4.9 03/95] ubi: fastmap: Dont flush fastmap work on detach
Date: Sun, 22 Apr 2018 15:52:32 +0200
Message-Id: <20180422135210.576881043@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180422135210.432103639@linuxfoundation.org>
References: <20180422135210.432103639@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1598454908575503165?=
X-GMAIL-MSGID: =?utf-8?q?1598455863624406433?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Richard Weinberger <richard@nod.at>

commit 29b7a6fa1ec07e8480b0d9caf635a4498a438bf4 upstream.

At this point UBI volumes have already been free()'ed and fastmap can no
longer access these data structures.

Reported-by: Martin Townsend <mtownsend1973@gmail.com>
Fixes: 74cdaf24004a ("UBI: Fastmap: Fix memory leaks while closing the WL sub-system")
Cc: stable@vger.kernel.org
Signed-off-by: Richard Weinberger <richard@nod.at>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/mtd/ubi/fastmap-wl.c |    1 -
 1 file changed, 1 deletion(-)

--- a/drivers/mtd/ubi/fastmap-wl.c
+++ b/drivers/mtd/ubi/fastmap-wl.c
@@ -362,7 +362,6 @@ static void ubi_fastmap_close(struct ubi
 {
 	int i;
 
-	flush_work(&ubi->fm_work);
 	return_unused_pool_pebs(ubi, &ubi->fm_pool);
 	return_unused_pool_pebs(ubi, &ubi->fm_wl_pool);
 
