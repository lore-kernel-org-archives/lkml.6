Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx4+MaRPpCCDpiB+BNwYLKjUwUjfBYxrEmapo8cZuB9hPXPUI5HMlBjDsBAsJZoNtP/A/HAjc
ARC-Seal: i=1; a=rsa-sha256; t=1524405702; cv=none;
        d=google.com; s=arc-20160816;
        b=PEX9TdZDG2M5AV+5gKPPzJmOBl5eiAhPpqA8zF+g2+aEBF6kzPjvbm/WMC0lxBxZMz
         6+8Hkt94wz2RkneaHO9lvM34VHICfYXnLUQcvsC83d2VaBfFaauiEiMv72zVh9A858c7
         NAO2L8f78UtTxWv8ZG6td9jXDHd4EgLGRE1+ux6wWWgiMlEPf/KtQ5oishaHlrhohBPp
         M+hC4sBxG1mHPcDdfLZJCRgBiukuvV9LXDfm2Dm34VvkK53TSfxqvJJcWSmmG2gxOKty
         hFKQn3YKtoWWz0l+cvkJh5eZvzwwg570T8jMlebU42jcQI6bXH+0mHzS4f+ccIv75krT
         oMqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=6XANeKfg7Z4PaOVJ8eyzCAOm/HiCg6tBy5rn7iuv2Ds=;
        b=bt7UhBzl2C5y1V51TcBkiZIunbE6yMK6ACLvA6ajjRTGcbJXo8C28jphF43EbjCC+0
         AOv77Mh/f2Nfjzg9M668Aok34PvtrHAyczljeH+VuTWUD4Dy6KrQZMTPAHf/vybgpN2c
         Y0oHNHh1qbVmhpseNGMFb2P7tEK0xZAUdzpD9Qn8u2L9C4Je3+EOyT9d45VANE1sUg9H
         7prKytsQ9ZuukYoCu/Yde5v3hTRINV3ug6snoxSiMszUjcjiI7GZUOxDU9qKtp1rTAsW
         /fZ2BlM0IWn1ljxlHQxoaXZL4vEHhngxlBr7ry9lnViJgKopFUWpUOY1mT3JLCb8yqYI
         JU3A==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Heinz Mauelshagen <heinzm@redhat.com>,
	Mike Snitzer <snitzer@redhat.com>
Subject: [PATCH 4.16 118/196] dm raid: fix nosync status
Date: Sun, 22 Apr 2018 15:52:18 +0200
Message-Id: <20180422135110.345489248@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180422135104.278511750@linuxfoundation.org>
References: <20180422135104.278511750@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1598455234446912877?=
X-GMAIL-MSGID: =?utf-8?q?1598455234446912877?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.16-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Heinz Mauelshagen <heinzm@redhat.com>

commit 880bcce0dcc3172fe865352b492c41d85290cb8d upstream.

Fix a race for "nosync" activations providing "aa.." device health
characters and "0/N" sync ratio rather than "AA..." and "N/N".  Occurs
when status for the raid set is retrieved during resume before the MD
sync thread starts and clears the MD_RECOVERY_NEEDED flag.

Cc: stable@vger.kernel.org # 4.16+
Signed-off-by: Heinz Mauelshagen <heinzm@redhat.com>
Signed-off-by: Mike Snitzer <snitzer@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/md/dm-raid.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- a/drivers/md/dm-raid.c
+++ b/drivers/md/dm-raid.c
@@ -3408,7 +3408,8 @@ static sector_t rs_get_progress(struct r
 		set_bit(RT_FLAG_RS_IN_SYNC, &rs->runtime_flags);
 
 	} else {
-		if (!test_bit(MD_RECOVERY_INTR, &recovery) &&
+		if (!test_bit(__CTR_FLAG_NOSYNC, &rs->ctr_flags) &&
+		    !test_bit(MD_RECOVERY_INTR, &recovery) &&
 		    (test_bit(MD_RECOVERY_NEEDED, &recovery) ||
 		     test_bit(MD_RECOVERY_RESHAPE, &recovery) ||
 		     test_bit(MD_RECOVERY_RUNNING, &recovery)))
