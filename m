Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx4/YVVJWE+g/svq8LaY9+g8u+edp/ohV9KXBwO1w1bDa5FDnORWfeeVzO8yb3ARfFAuZp32N
ARC-Seal: i=1; a=rsa-sha256; t=1524406569; cv=none;
        d=google.com; s=arc-20160816;
        b=mCYi0D/kf2/Dddhorde1egeaIvGUw1qenWFqn+hugaZLAST4Egi9C4DZk3WWyPJt7T
         FESlbGPMjsE78ZmkYtQZLQ5eB+yAHlkz2Mu+5Vf0fHDTr/mEPefzEpikECTTRsIiikAU
         gOwXFduWTLXmLhUKLDLmdCUeX9UMs2yGkskcqnFuSiqnlrXE4v5gg93ui8sE9iDKw4ar
         hzoMjV/f50O8HsRrKgMeKX5axqMcTLJ8ZaNFBprO2ip2VIodQTZ5fYSovheJ3d7pt9/c
         bSVtWpXpf988iczPTcHl1BcBJ7LSJNPbxZpSiuub9jDLUGAAHWFcG4kpINp9rYNN4WTt
         zM+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=3ROy6VOEZJeJ33r+H0/FN3Fr5M93MFPAjG/Md/aNYN4=;
        b=qzzjNWBX1dbhsrtCbhQ9sYIWWEnkWiBE3Lkw6P3AbPFDQ1cKujBmezRYXHzcKDYCHk
         1opEPxItjZ6LWgFiHcY+TLeJf+X9WGVpoHjLNt5RKtb5aOWwDU8+9qE+G5d+EakK4ZEy
         /FcQ/ZLi4a+0gSBJS0e4x4CB6ouEc5o/fUi3RoEvY0km+ZBBizhHWKPEgGVu8rJRAs9g
         6xtSu1gFaSur2H42fJEBtN49cMPIdCD7ITHGs0eWFkULiIq6PVkANXcJaApCCIOCYC/v
         ojxGSPJsIvGtli66/VLPCwkdJxtz/aAsEaJce0zItgpBrFMCKis+c87AUxSUSxEUCHvo
         GMDw==
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
Subject: [PATCH 4.4 23/97] ubi: fastmap: Dont flush fastmap work on detach
Date: Sun, 22 Apr 2018 15:53:01 +0200
Message-Id: <20180422135306.338619311@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180422135304.577223025@linuxfoundation.org>
References: <20180422135304.577223025@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1598454908575503165?=
X-GMAIL-MSGID: =?utf-8?q?1598456142546087431?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

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
@@ -360,7 +360,6 @@ static void ubi_fastmap_close(struct ubi
 {
 	int i;
 
-	flush_work(&ubi->fm_work);
 	return_unused_pool_pebs(ubi, &ubi->fm_pool);
 	return_unused_pool_pebs(ubi, &ubi->fm_wl_pool);
 
