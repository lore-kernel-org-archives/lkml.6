Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELujUxgf0Yd70YD1jgPV+tV/vyZGpVIiapz9ghkhIftRRMG6YsotCOfPv/XLWfUCr7O5Fs1W
ARC-Seal: i=1; a=rsa-sha256; t=1520954883; cv=none;
        d=google.com; s=arc-20160816;
        b=hvVMYGkKFL/GqcYBMYNCykSobYSZ82pyPy+n6hQ2I5Baq+ivW5Igt65IiS9eu3wEqr
         NqRMV8zm9vWwiWitVGuc1MXflE1X5WbgySBiOmZAsGo7fdEoM92vDxCXRp1Xqx2rg6t1
         h1x9MJnEpWtHan/2KET1XOKdYLWHJb9TUyM77J6ALzvoau6s1K14SChzVC/weyvMV6j2
         8s0yhIz78zGkiA5n6zKLisqXnhTl8P4aOZrACFt+hpAgArjdPG8Y9sDMQ0hv8p29er18
         6JWgDVNbn7rzoFn50IQvIW1GMnulFwhJXo8T0U8JTGCI9L27ma4UbD6rZEUX9k1IdjRz
         Z8Tw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=jRD6dSdzktkKhx/BhIjrDfOOwQ7Du9YAjKdCD8v39Fc=;
        b=ex66oD4biIjnaT+839qm7pSVHroQoOAYfE6wJOsw9fWPMJZiwJdfS1sqXZwtWySY2I
         5snS31U/EukZilcN3baLJ0/yqi0oW0kIBuRgjXhEJh2LdleHUEew11nRi4Aq8rH180K/
         Wjv1ZBFToAV7Gy1EhCVabWfn9t7Hjx/H+ogVmXsSWeCWXxKrjnG3VtTH1g9xKdEkU/5P
         qe9ovF1Uh2V4Ih3/RXhugFUYpw24iF1uHo9LYfG/TAcBOYLAorSept2NLMxl06n4re8d
         rZYrSNBMMmRYpISr9PZlwp/i2gxqz88LyX+hJgZJx+zAbDvVlCVGIVgVhFfLma7pepVc
         bSvQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	syzbot+41cdaf4232c50e658934@syzkaller.appspotmail.com,
	Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 4.15 006/146] mac80211_hwsim: dont use WQ_MEM_RECLAIM
Date: Tue, 13 Mar 2018 16:22:53 +0100
Message-Id: <20180313152321.100368498@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180313152320.439085687@linuxfoundation.org>
References: <20180313152320.439085687@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1594836788255644141?=
X-GMAIL-MSGID: =?utf-8?q?1594836788255644141?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Johannes Berg <johannes.berg@intel.com>

commit ce162bfbc0b601841886965baba14877127c7c7c upstream.

We're obviously not part of a memory reclaim path, so don't set the flag.

This also causes a warning in check_flush_dependency() since we end up
in a code path that flushes a non-reclaim workqueue, and we shouldn't do
that if we were really part of reclaim.

Reported-by: syzbot+41cdaf4232c50e658934@syzkaller.appspotmail.com
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/net/wireless/mac80211_hwsim.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/net/wireless/mac80211_hwsim.c
+++ b/drivers/net/wireless/mac80211_hwsim.c
@@ -3455,7 +3455,7 @@ static int __init init_mac80211_hwsim(vo
 
 	spin_lock_init(&hwsim_radio_lock);
 
-	hwsim_wq = alloc_workqueue("hwsim_wq",WQ_MEM_RECLAIM,0);
+	hwsim_wq = alloc_workqueue("hwsim_wq", 0, 0);
 	if (!hwsim_wq)
 		return -ENOMEM;
 
