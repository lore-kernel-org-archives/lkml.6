Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELt3HrR2cCmKFD3jf/fwgC4axSJ6KMzm5NQCtDzV/k2XEm+b56VwBm3Ht2rr2RE07LwDX7M+
ARC-Seal: i=1; a=rsa-sha256; t=1519411843; cv=none;
        d=google.com; s=arc-20160816;
        b=Ghw+wdllOWH6BqGELsHhNQj70NApvXg6IdfKfl8mwKewkiLax0CrcxFzElQpousIiZ
         L+Fixs5O7diO0/sKnbazwUuoEeDxfn5jF2eN7yGastpbQSrU//STuESDyp2hKQpZhmQm
         vcSZr/kFyJr2OwJpvTntz3CJdXjmC5T8GtJVPdA9q+ipiYKIa23/Y95AwuwbCwUsuEYe
         PWHeEkFoRxffGu9P71L8kb0Vckyi69/YHx5njGjIFQ2iVKxXEM15fsRP3As4dV1QpAhO
         B3xAaVgg6D3zgvZwQzIPh2mJhHdhxFLRzWaHD1cIVNcL+PJ+Jg6P2RSaY9qFFfDhUQds
         Nm8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=t0WPeKXdslwf1C/HGQB5yT5pSOS0VffIJSCT5pA0JbA=;
        b=QOR4RHFw/sHVrovsXWLS9/JUq+ziVHUFAKDW5HlBIYzPD4pn1AAlPo+TsCGGYQZQeE
         SlTlsvtxUvlM+W3MDJvD/CR/UYEq2mEwmSMyLpC0l6e65s5yi/VRnm44Jhy2mcTgWohM
         tUU2f97Y8pdYbeqDIgCdKvLsi9cA6NikdSbliTmL5fmyPj6iQjHPEM7/e7a8pJlktxZg
         bV44b6dHptqwKVMZ4SpqgZ/bR3d1n5j6avB6hfrZMLg3lrPNjMOJ+2Iez+PuW2Y8Dwpu
         v4RmbMOUQgW2cxovTSqUg5TH+o2G6jBfuEr61t1yz20f+C88DXyEim615WmpeuJbY5gR
         d7FA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	syzbot+1ddfb3357e1d7bb5b5d3@syzkaller.appspotmail.com,
	Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 4.14 006/159] cfg80211: check dev_set_name() return value
Date: Fri, 23 Feb 2018 19:25:14 +0100
Message-Id: <20180223170743.886605795@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180223170743.086611315@linuxfoundation.org>
References: <20180223170743.086611315@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1593217738640080988?=
X-GMAIL-MSGID: =?utf-8?q?1593218793290158345?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Johannes Berg <johannes.berg@intel.com>

commit 59b179b48ce2a6076448a44531242ac2b3f6cef2 upstream.

syzbot reported a warning from rfkill_alloc(), and after a while
I think that the reason is that it was doing fault injection and
the dev_set_name() failed, leaving the name NULL, and we didn't
check the return value and got to rfkill_alloc() with a NULL name.
Since we really don't want a NULL name, we ought to check the
return value.

Fixes: fb28ad35906a ("net: struct device - replace bus_id with dev_name(), dev_set_name()")
Reported-by: syzbot+1ddfb3357e1d7bb5b5d3@syzkaller.appspotmail.com
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 net/wireless/core.c |    8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

--- a/net/wireless/core.c
+++ b/net/wireless/core.c
@@ -439,6 +439,8 @@ struct wiphy *wiphy_new_nm(const struct
 		if (rv)
 			goto use_default_name;
 	} else {
+		int rv;
+
 use_default_name:
 		/* NOTE:  This is *probably* safe w/out holding rtnl because of
 		 * the restrictions on phy names.  Probably this call could
@@ -446,7 +448,11 @@ use_default_name:
 		 * phyX.  But, might should add some locking and check return
 		 * value, and use a different name if this one exists?
 		 */
-		dev_set_name(&rdev->wiphy.dev, PHY_NAME "%d", rdev->wiphy_idx);
+		rv = dev_set_name(&rdev->wiphy.dev, PHY_NAME "%d", rdev->wiphy_idx);
+		if (rv < 0) {
+			kfree(rdev);
+			return NULL;
+		}
 	}
 
 	INIT_LIST_HEAD(&rdev->wiphy.wdev_list);
