Return-Path: <kkamagui@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1519589105; cv=none;
        d=google.com; s=arc-20160816;
        b=mYeDmslu85n2toLWrzAsSlkpHs3MtQnOqCwIRyEcNMIiDB2+2S+3QhSX0ixikjrqRP
         KtYW3tjK3wnXCIOliiviGUwP6lc/yR9vLT04O8dhBmLNSAr3RqXf23eAAk/45c9JJEeV
         j7w37pbv8kKF7QHnC78ka+z0JEdPoIRiWhGdnfeddCM7sppn0uC2frm6fxgNYaiQ1ofK
         3CGfkcyssprQPxU0r02HGA40bHijhtBKSv0hm3Qn3m9Sc2ffoznltQk8wwHZe99iYjvH
         9fzmuo/uC9RbDQEarwXas6U6eujmtmX5LmIotpOKG347bFEQvl/YduIaHvPSAw6bUKtR
         sYZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:dkim-signature:arc-authentication-results;
        bh=XubpVW1oXu9F4J45dpU808x0/zewJPLeW9Hj95aKgNY=;
        b=DoeiFC1fqXWKkgoozVME5vvMr0ZgRPSmPCElbaoljw9PQJ46dEwHzHgAb61a53YYm5
         h0e0p/ely+0tcBqrE1irGLX6fi6KDj19Ux9NNPp9kvCvtnN4p7W7/xfGo7kkqvLg1tgn
         z2brb7ieeSq7NVFiNMPC6ThEkyvHZB0j6YtM4SSSbZFrbcvoOHHHXB3dLMDtRNwevlrz
         Q+0hTYgpA14Rnf00By8MVZZFBZZdtF3QRIw045+SfK0IS58xnIvebW9zMs4WIUV5S1Hj
         BahiAzdCTLkvhjD/8vSB+HOx7fUNxOFiVwTsWf+Ndv4pgA9fZkMHtCYzIyCD9OVLQBb+
         MlaA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=nnoTzFEP;
       spf=pass (google.com: domain of kkamagui@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=kkamagui@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=nnoTzFEP;
       spf=pass (google.com: domain of kkamagui@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=kkamagui@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
X-Google-Smtp-Source: AG47ELvJ73yDpqlWxq7FKj4B71WLxz4EZgXyPMH8ynuO8MuR+S1W0JKpd8xEZpUc6R5kqnPzrpAt19srlfFOoj4tCDQ=
MIME-Version: 1.0
In-Reply-To: <20180223105220.GA12058@kroah.com>
References: <20180223101350.8344-1-kkamagui@gmail.com> <20180223105220.GA12058@kroah.com>
From: Seunghun Han <kkamagui@gmail.com>
Date: Mon, 26 Feb 2018 05:05:04 +0900
Message-ID: <CAHjaAcTVUxm6LnD_3sp2BwGgR9ustuctoHUBFkMD1nZh4o6bTA@mail.gmail.com>
Subject: Re: [PATCH] x86: mce: fix kernel panic when check_interval is changed
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Tony Luck <tony.luck@intel.com>, Borislav Petkov <bp@alien8.de>, linux-edac@vger.kernel.org,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593186374882748310?=
X-GMAIL-MSGID: =?utf-8?q?1593404665585793306?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hello, Greg.

2018-02-23 19:52 GMT+09:00 Greg Kroah-Hartman <gregkh@linuxfoundation.org>:
> On Fri, Feb 23, 2018 at 07:13:50PM +0900, Seunghun Han wrote:
>> I am Seunghun Han and a senior security researcher at National Security
>> Research Institute of South Korea.
>>
>> I found a critical security issue which can make kernel panic in userspace.
>> After analyzing the issue carefully, I found that MCE driver in the kernel
>> has a problem which can be occurred in SMP environment.
>>
>> The check_interval file in
>> /sys/devices/system/machinecheck/machinecheck<cpu number> directory is a
>> global timer value for MCE polling. If it is changed by one CPU, MCE driver
>> in kernel calls mce_restart() function and broadcasts the event to other
>> CPUs to delete and restart MCE polling timer.
>>
>> The __mcheck_cpu_init_timer() function which is called by mce_restart()
>> function initializes the mce_timer variable, and the "lock" in mce_timer is
>> also reinitialized. If more than one CPU write a specific value to
>> check_interval file concurrently, one can initialize the "lock" in mce_timer
>> while the others are handling "lock" in mce_timer. This problem causes some
>> synchronization errors such as kernel panic and kernel hang.
>>
>> It is a critical security problem because the attacker can make kernel panic
>> by writing a value to the check_interval file in userspace, and it can be
>> used for Denial-of-Service (DoS) attack.
>
> As only root can write to that file, it's not that critical of an issue,
> but yes, this is a problem.  Nice find and fix.
I agree with your opinion.
Thank you for your advice.

Best regards.

Seunghun.
>>
>> To fix this problem, I changed the __mcheck_cpu_init_timer() function to
>> reuse mce_timer instead of initializing it. The purpose of the function is
>> to restart the timer and it can be archived by calling
>>
>> Signed-off-by: Seunghun Han <kkamagui@gmail.com>
>
> Cc: stable <stable@vger.kernel.org>
> Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>
