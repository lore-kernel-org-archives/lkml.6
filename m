Return-Path: <richard@nod.at>
X-Google-Smtp-Source: AB8JxZqn+krAhruX0MuAP7z3/4liAch80wi3jdBuSG9e9wWHFXD7wnKo7MeFR2hdWFDCS8KQIjWW
ARC-Seal: i=1; a=rsa-sha256; t=1526492223; cv=none;
        d=google.com; s=arc-20160816;
        b=j2CneS8FymzTdkYCqICH1M7LCH6zYyEAAd6MDYcLbS39uBvRh2yywQqTJ3ouZwSAet
         HWkupC53L27sJXf9thGQjIzbeemmE3NdG2Gb+zaqTsZOEltzzj5kcZ0gSHFdPzF/E9Xi
         WItg3Eo0kvexKANV2jVJfU/e1oDQ5vLdSMAip+rlZaiFRF4iVrtk+MKek3GmQyl42RLB
         7VFAOKKmvXvU07+jXl/TK2B6SzmOC/wkOwXBw5OoDqUj5vNRuV6kmbjUPR3rHcP790nH
         PiLGVCigfMwfJNPT3lWndMRN1l2tI5lY3BSA3rsjfgICzafmHwtQIHXTsXeiVQ8UGm1w
         rBTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:arc-authentication-results;
        bh=yBS51nUeNaW0rLKF4Tj9PheSYDjDLFvIk86Uhpd1gLo=;
        b=V2bz6vQl+xWnlqiHZVzL3BLBNVnw5+n0mzxI/geLd5ycE8fBmrl0AHoafvemacUOGZ
         dGS4qLlPDrb7kDATWV9BWiXDMiAs4i3VmuiUEI5cZ/KV9Atynj6ae1vaVNPjqyFohxnv
         MHYOCfUh0JUmbxpf+3Bt6vSaLXei/38bAB5JPkoOikt9I5gteRcF31fhjBunmlNtvwSf
         GBwkZqvEL3iwMd8cKAHxdO5v7pznrbOWqiiLpgvHo6S6ycIveYm9B4j9XciB8N/+cd6N
         Uu689f7AqCeDkEgTiP6R3qPF5FX2r3niQ+poU0jNP7rbsB60dcKtyyG6nto4QIvruJIC
         RvSg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of richard@nod.at designates 195.201.40.130 as permitted sender) smtp.mailfrom=richard@nod.at
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of richard@nod.at designates 195.201.40.130 as permitted sender) smtp.mailfrom=richard@nod.at
From: Richard Weinberger <richard@nod.at>
To: Ben Hutchings <ben.hutchings@codethink.co.uk>
Cc: Martin Townsend <mtownsend1973@gmail.com>, stable@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 4.4 23/97] ubi: fastmap: Dont flush fastmap work on detach
Date: Wed, 16 May 2018 19:37:01 +0200
Message-ID: <2235171.AyZ2c50PG7@blindfold>
In-Reply-To: <1526489629.9159.147.camel@codethink.co.uk>
References: <20180422135304.577223025@linuxfoundation.org> <20180422135306.338619311@linuxfoundation.org> <1526489629.9159.147.camel@codethink.co.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598454908575503165?=
X-GMAIL-MSGID: =?utf-8?q?1600643109857615638?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Ben,

Am Mittwoch, 16. Mai 2018, 18:53:49 CEST schrieb Ben Hutchings:
> I don't see how this change can fix a use-after-free.  If this function
> can be called with *ubi already freed, then the rest of the function
> body is also not safe to run.  But I don't think that is the case.

thanks a lot for digging into this!
It is not about ubi (struct ubi_device) being free()'d, it is about
ubi->volumes[].

> ubi->fm_work doesn't depend on any other structure (except a global
> workqueue, which won't go away).
> 
> It seems to me that the bug is really a race condition, and removing
> the flush_work() makes it harder to hit that condition.  The proper fix
> would be to call flush_work() (or cancel_work_sync()) before the UBI
> volumes are freed.

That's a very valid point.
I think cancel_work_sync() is the right thing to do.

Thanks,
//richard
