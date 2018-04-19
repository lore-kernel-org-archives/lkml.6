Return-Path: <bp@suse.de>
X-Google-Smtp-Source: AIpwx4+r1Mm2cWVtiZ+Lp9EWcHixEbZvsbK1HSum9g66yhrnSKX7TzkOkAmYsDlCJ2k2vsCDiOWv
ARC-Seal: i=1; a=rsa-sha256; t=1524134916; cv=none;
        d=google.com; s=arc-20160816;
        b=HzbBmDjMbGL+Btna54WoPKDxx3/KRYtl9BzkGYPEEXfWj4TIQc6l+VXLQHP1n69kov
         N75fZsbnDobsReQmCEyPI0rTj9cz7tzOPOLNbBQ6a34j6xPRJa7ICPeRnQHW6H2QybHu
         jngSKKPVe4s7nAewE47AstPxJgChLuJOy4va4w0pwzf6oMfLb/A+EtwdHHvpZ6aCUk6q
         MEM8kK+r1CZFpqbN3AGZwcy/Hky8vT+TRWLgWF4Ic2zcVjpg7SO81BLO0DZPLQU4xA2M
         OINBtezKWhiKGTovYy5yagKiGmM1gyqs7zZcC7ChYMNH6mitKu4SeJu0A0h4ZNvqIGsL
         hbjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-transfer-encoding
         :content-disposition:mime-version:references:message-id:subject:cc
         :to:from:date:arc-authentication-results;
        bh=Ro4C4JDwDroho+zqS3r8ijIKXyZWYpirZt9z2NIhO78=;
        b=Y0BnRcMrLvNzyBDcneBgp83qnqNXCeuXheZQeQkbQHIHYUhUGSTv+ItgaR4/ziwTzy
         POqxRleo9sC4Lj3oLeWlxzuTt1Ei/VWVeBUP+JVKaJET9iuFcRRNneZISESGgZlO9OkX
         Zwaz6BXXa37oQQDLJVsKwmmE8elBdXQGre0ASYgEc3B9+ROsTsuStms1dCi7YULHITT8
         uhjALm1HpuaDP2wq+aksmviRPhlm5K0YepYBWth6cv1L/3TXlh2DuudjXFPs3GtQCuad
         ImABtkpe9TRK6Y989yVWC5clih5MM5Jzvixk2AZF5xDnLokz9DqtDKDojPpd1DR5/Z0U
         +W0g==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of bp@suse.de designates 195.135.220.15 as permitted sender) smtp.mailfrom=bp@suse.de
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of bp@suse.de designates 195.135.220.15 as permitted sender) smtp.mailfrom=bp@suse.de
Date: Thu, 19 Apr 2018 12:48:29 +0200
From: Borislav Petkov <bp@suse.de>
To: Vitezslav Samel <vitezslav@samel.cz>
Cc: "Raj, Ashok" <ashok.raj@intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-kernel@vger.kernel.org
Subject: Re: 4.15.17 regression: bisected: timeout during microcode update
Message-ID: <20180419104829.GE3896@pd.tnic>
References: <20180418081140.GA2439@pc11.op.pod.cz>
 <20180418100721.GA5866@pd.tnic>
 <20180418120839.GA5655@pc11.op.pod.cz>
 <20180418122212.GA4290@pd.tnic>
 <20180418135330.GA23580@araj-mobl1.jf.intel.com>
 <20180419053531.GA2224@pc11.op.pod.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180419053531.GA2224@pc11.op.pod.cz>
User-Agent: Mutt/1.9.3 (2018-01-21)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598070825045426546?=
X-GMAIL-MSGID: =?utf-8?q?1598171294836953655?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Thu, Apr 19, 2018 at 07:35:31AM +0200, Vitezslav Samel wrote:
> > - Can you remove your builtin microcode, 
> > - rename the /lib/firmware/intel-ucode so we don't find it during late loading. 
> > - let the system boot completely
> > - then rename the intel-ucode back for this test.
> > - write 1 to reload and see if that update succeeds or fails?
> 
>   Just tested, it fails.

Can you apply the below patch, do the exact same exercise and catch the
output? Over serial console or netconsole or if nothing else, do a video
of the screen with a phone and upload it somewhere?

Thx.

---
diff --git a/arch/x86/kernel/cpu/microcode/core.c b/arch/x86/kernel/cpu/microcode/core.c
index 10c4fc2c91f8..374ec1d75d89 100644
--- a/arch/x86/kernel/cpu/microcode/core.c
+++ b/arch/x86/kernel/cpu/microcode/core.c
@@ -553,6 +553,8 @@ static int __reload_late(void *info)
 	enum ucode_state err;
 	int ret = 0;
 
+	pr_info("%s: CPU%d\n", __func__, cpu);
+
 	/*
 	 * Wait for all CPUs to arrive. A load will not be attempted unless all
 	 * CPUs show up.
@@ -560,6 +562,8 @@ static int __reload_late(void *info)
 	if (__wait_for_cpus(&late_cpus_in, NSEC_PER_SEC))
 		return -1;
 
+	pr_info("%s: CPU%d reloading\n", __func__, cpu);
+
 	spin_lock(&update_lock);
 	apply_microcode_local(&err);
 	spin_unlock(&update_lock);
@@ -571,9 +575,12 @@ static int __reload_late(void *info)
 	} else if (err == UCODE_UPDATED || err == UCODE_OK) {
 		ret = 1;
 	} else {
+		pr_info("%s: CPU%d returning 0x%x\n", __func__, cpu, ret);
 		return ret;
 	}
 
+	pr_info("%s: CPU%d waiting to exit\n", __func__, cpu);
+
 	/*
 	 * Increase the wait timeout to a safe value here since we're
 	 * serializing the microcode update and that could take a while on a

-- 
Regards/Gruss,
    Boris.

SUSE Linux GmbH, GF: Felix Imendörffer, Jane Smithard, Graham Norton, HRB 21284 (AG Nürnberg)
-- 
