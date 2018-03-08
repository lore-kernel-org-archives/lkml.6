Return-Path: <brice.goglin@gmail.com>
X-Google-Smtp-Source: AG47ELvH8eIdJ3eRtqSyQ5RKahjIFhyw7+WWUj4BR4xrP0kTN6gVc+t1Fgfgt5QzVIXtSw0RI2ws
ARC-Seal: i=1; a=rsa-sha256; t=1520541679; cv=none;
        d=google.com; s=arc-20160816;
        b=So1ZnL/LGurVgr42fbfKTAogNO1agSZL3JGx/ITkSaV42KoXYTxTUKiUF4/oJ1HWot
         s3DpP3wdcBwo1Y4+Bz5Td1uEuktqCZqOdKZH7TGAJ4EU+B3jZzsTXGrJKU0LNV7ow7EE
         DpjuttLwz6GrOwHzf9o2A1ilD/XFwmUbq0OMz3UWf76EX3eTWEnE1Go8YwOWPixTH+72
         TtM6LPbXCisZaFcM1qrd9pM1b0GD4GFaaaREtknYHCGVXLTIsQwsqUVsgFF4ScGq58SX
         kUots0FdoCh6h2mnN2KQxNc+F5Z6wkCd/I+mTws6eFVbbq7R2Nk+TcLRZn4hyGv4y1OE
         tQLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-language:content-transfer-encoding:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :arc-authentication-results;
        bh=QhVUPcSRupUeT3H436yMCUrTZiaNHoYHmTJ0/vcp2B0=;
        b=D4lWKy9nRAAjhLUzyJASoHF9pYAU5C4QhveF2CPODv3vm+HG51yhsUmMfCHT76PD2b
         7MVzI/32noAyrsvSY+fg7PhVLUxNNoRZhnP3f7Uf3sS9+HfosctJp5TWVZuBwysdH7cb
         qSj2mRUSsOxvqZCs02W6ZinCA9/wStZH63BGUZsmkl+IhTTiy2Gm88HCRGVF9BP/xOmR
         NMVWfe5awpThaVoPt/dq0s0t1ehYinSz81X8XndMX8J7zf2HGNBMcsi5mbD7WlMTbT5X
         Yio9vSsRO5rIFb6zogSHR7Enl+svl/jWKNIx+Jhwx+KO9jg3JSd85G5yH0w/GSrprO29
         U7rA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning brice.goglin@gmail.com does not designate 192.134.164.104 as permitted sender) smtp.mailfrom=brice.goglin@gmail.com;
       dmarc=fail (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning brice.goglin@gmail.com does not designate 192.134.164.104 as permitted sender) smtp.mailfrom=brice.goglin@gmail.com;
       dmarc=fail (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
X-IronPort-AV: E=Sophos;i="5.47,442,1515452400";
   d="scan'208";a="257544008"
Subject: Re: [PATCH v7 13/13] arm64: topology: divorce MC scheduling domain
 from core_siblings
To: Morten Rasmussen <morten.rasmussen@arm.com>,
 Jeremy Linton <jeremy.linton@arm.com>
Cc: mark.rutland@arm.com, vkilari@codeaurora.org, lorenzo.pieralisi@arm.com,
 catalin.marinas@arm.com, tnowicki@caviumnetworks.com,
 gregkh@linuxfoundation.org, will.deacon@arm.com, dietmar.eggemann@arm.com,
 rjw@rjwysocki.net, linux-kernel@vger.kernel.org, ahs3@redhat.com,
 linux-acpi@vger.kernel.org, palmer@sifive.com, hanjun.guo@linaro.org,
 sudeep.holla@arm.com, austinwc@codeaurora.org,
 linux-riscv@lists.infradead.org, john.garry@huawei.com,
 wangxiongfeng2@huawei.com, linux-arm-kernel@lists.infradead.org,
 lenb@kernel.org
References: <20180228220619.6992-1-jeremy.linton@arm.com>
 <20180228220619.6992-14-jeremy.linton@arm.com>
 <20180301155216.GI4589@e105550-lin.cambridge.arm.com>
 <5d6bf4cf-2f6d-d123-f17f-d47d8e74c16c@arm.com>
 <20180306160721.GJ4589@e105550-lin.cambridge.arm.com>
 <8ac3567c-9fd8-4b0c-121c-287a027b5156@arm.com>
 <20180307130623.GK4589@e105550-lin.cambridge.arm.com>
From: Brice Goglin <brice.goglin@gmail.com>
Message-ID: <d6497158-c58f-4fd4-4613-699fb2af7a61@gmail.com>
Date: Thu, 8 Mar 2018 21:41:17 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180307130623.GK4589@e105550-lin.cambridge.arm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593684162193428124?=
X-GMAIL-MSGID: =?utf-8?q?1594403512289464938?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>


> Is there a good reason for diverging instead of adjusting the
> core_sibling mask? On x86 the core_siblings mask is defined by the last
> level cache span so they don't have this issue. 

No. core_siblings is defined as the list of cores that have the same
physical_package_id (see the doc of sysfs topology files), and LLC can
be smaller than that.
Example with E5v3 with cluster-on-die (two L3 per package, core_siblings
is twice larger than L3 cpumap):
https://www.open-mpi.org/projects/hwloc/lstopo/images/2XeonE5v3.v1.11.png
On AMD EPYC, you even have up to 8 LLC per package.

Brice
