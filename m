Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x226rRq25VXuLpk6M6oKyiVPZOrDTQn2LpC797YOORDRV/Ytd6YE3s0DdiAqB3EKAiU+/F1jv
ARC-Seal: i=1; a=rsa-sha256; t=1519410837; cv=none;
        d=google.com; s=arc-20160816;
        b=k17ikisl461Jo58AE0RTPR3OD2KpMCAhbxXp4nFPi+5KnAzKKKq8n57Yq7pPXVVwzV
         F8ivxshpbpwA/FOnZlrb1xfe+25rSlkJbrKLetKg6bUHbsKZ1M05q/PYURdWdGszpAw/
         2AEm3/V0yY57CcDEirteeFAeDuRWRaPTtpFZ2xWtZsk3MSUegdylCgveGqJIXH8G79uC
         MNfaVnzpBzRxT7YtieWGH6hDjKHSp3l2yJdrsripZabsrFSpO8Ta3pyfNMv8wbu8VAZw
         3ILfi1ms2FE+zyypE0e0djkArgluARSjX4xqiS2X7coQZ4gXdIv3uDGbEMxKCWDpo81I
         y/Qw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=b+zlMjbF25QPxpui7HYHO2nT4Z8xSrtR+e43sCRCn7c=;
        b=I5UG1LdWYlnVPA4gUYAvMxaqqF/wa1kEDv39k0YMn06EcOtEWosPJbLJsHzxbGdz+O
         oRpuaFcCOho6fFcbRIAUlJOx3Rvt+lcSbE4U9Bj/rPNpMgIx2bfeSN7WTE0yzSTBCSPl
         fBF9920cy/+UY3O0Dtd0dRbFtWQtY4vKw9TZSCZJIVJoNzMgecH1XErROAiXFHSyOzoV
         eJ/zPge+oE0lWjWrl2eMXiSPkEDHjJDYl4A4qNUHfSszZmwC3P8FWHhMix/MwobK/+5U
         S7Tg1b3dMqWVhgOBQ4BrCIXLKBpfQgBTr6wKTH2hBM8ut9yK2gMqoWItG5SA8oy+W+VM
         UmsA==
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
Subject: [PATCH 4.4 003/193] cfg80211: check dev_set_name() return value
Date: Fri, 23 Feb 2018 19:23:56 +0100
Message-Id: <20180223170326.555798015@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180223170325.997716448@linuxfoundation.org>
References: <20180223170325.997716448@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1593217738640080988?=
X-GMAIL-MSGID: =?utf-8?q?1593217738640080988?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

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
@@ -390,6 +390,8 @@ struct wiphy *wiphy_new_nm(const struct
 		if (rv)
 			goto use_default_name;
 	} else {
+		int rv;
+
 use_default_name:
 		/* NOTE:  This is *probably* safe w/out holding rtnl because of
 		 * the restrictions on phy names.  Probably this call could
@@ -397,7 +399,11 @@ use_default_name:
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
 
 	INIT_LIST_HEAD(&rdev->wdev_list);
