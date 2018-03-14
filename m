Return-Path: <morten.rasmussen@arm.com>
X-Google-Smtp-Source: AG47ELuS6JTUzJGEktH91fxZGhF5xwE+tGUv2MyWE9BbtcPkfxfZRtrYBBYDv93LwrWIPO8+nDrx
ARC-Seal: i=1; a=rsa-sha256; t=1521031389; cv=none;
        d=google.com; s=arc-20160816;
        b=aKxrSU5upFSiMeJyCbtzdPRktNc/zy7uyf1iSZoQNiemgH8LES65cQqbHOfEWd22eU
         wDbQk9NsTZqO2YfQq/hU88yqegpT2Iwn0z/2lOvAr1kAaF68w7mhdLqcuPw+q97GK4bD
         wKJtDhsvXAPkQNUvhHLiTnD10oCPgOGqkALD7xx0SU5lG7HhCPrxrVnoZuf28DwVekjo
         OuigIxprBuLeGfwAEDcEbA1X51YYAydnU+bXF7Vu7H/TVue33UkpMDZ1udG6Sm2C3O7j
         GS2NehTby+4OQ1UJvheLhneZ2BfvbqD6WUlLpSeM0D/uFaCAUwG7bOqslpKX/XceIc1S
         jQSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:arc-authentication-results;
        bh=d62H7ILYG8CnOuf9i4iyNnGLgBSW8IIsa9odQduRPdw=;
        b=Y4bPQmEwzt3rUhSQW3/fAWVEU6foJKAMeiq/5ggJ/P5WKYwDgOzWcDycFxHW11xS4F
         nRAtMjwcFbcb+vcNN6pu1kfEGIDuWO6N7rEGYBpECtvktDhky1e5/FRl7t1ya5ot+Z1Y
         IQzz9+8S4pM2g/vfCY+LjX7bc1apksavldLloxZUrdt1xKVqzDziGqi5kN++aIMmk3ds
         mUWKa6V0ZTMAtnqGAzd+TKdhIROh1d1WUtq2kvNbDfJgr7tu7fl4ag7iC6DU+OsjJvAY
         CulZZlHUeol51CQzjljjUXRJ4nHjPdFrfV+4kWl2UYXMQfBAdOz5qGXLElTsTSJtue7P
         ITZQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of morten.rasmussen@arm.com designates 217.140.101.70 as permitted sender) smtp.mailfrom=morten.rasmussen@arm.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of morten.rasmussen@arm.com designates 217.140.101.70 as permitted sender) smtp.mailfrom=morten.rasmussen@arm.com
Date: Wed, 14 Mar 2018 12:43:02 +0000
From: Morten Rasmussen <morten.rasmussen@arm.com>
To: Brice Goglin <brice.goglin@gmail.com>
Cc: Jeremy Linton <jeremy.linton@arm.com>, mark.rutland@arm.com,
	vkilari@codeaurora.org, lorenzo.pieralisi@arm.com,
	catalin.marinas@arm.com, tnowicki@caviumnetworks.com,
	gregkh@linuxfoundation.org, will.deacon@arm.com,
	dietmar.eggemann@arm.com, rjw@rjwysocki.net,
	linux-kernel@vger.kernel.org, ahs3@redhat.com,
	linux-acpi@vger.kernel.org, palmer@sifive.com,
	hanjun.guo@linaro.org, sudeep.holla@arm.com,
	austinwc@codeaurora.org, linux-riscv@lists.infradead.org,
	john.garry@huawei.com, wangxiongfeng2@huawei.com,
	linux-arm-kernel@lists.infradead.org, lenb@kernel.org
Subject: Re: [PATCH v7 13/13] arm64: topology: divorce MC scheduling domain
 from core_siblings
Message-ID: <20180314124302.GL4589@e105550-lin.cambridge.arm.com>
References: <20180228220619.6992-1-jeremy.linton@arm.com>
 <20180228220619.6992-14-jeremy.linton@arm.com>
 <20180301155216.GI4589@e105550-lin.cambridge.arm.com>
 <5d6bf4cf-2f6d-d123-f17f-d47d8e74c16c@arm.com>
 <20180306160721.GJ4589@e105550-lin.cambridge.arm.com>
 <8ac3567c-9fd8-4b0c-121c-287a027b5156@arm.com>
 <20180307130623.GK4589@e105550-lin.cambridge.arm.com>
 <d6497158-c58f-4fd4-4613-699fb2af7a61@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d6497158-c58f-4fd4-4613-699fb2af7a61@gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593684162193428124?=
X-GMAIL-MSGID: =?utf-8?q?1594917010445594994?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Thu, Mar 08, 2018 at 09:41:17PM +0100, Brice Goglin wrote:
> 
> > Is there a good reason for diverging instead of adjusting the
> > core_sibling mask? On x86 the core_siblings mask is defined by the last
> > level cache span so they don't have this issue. 
> 
> No. core_siblings is defined as the list of cores that have the same
> physical_package_id (see the doc of sysfs topology files), and LLC can
> be smaller than that.
> Example with E5v3 with cluster-on-die (two L3 per package, core_siblings
> is twice larger than L3 cpumap):
> https://www.open-mpi.org/projects/hwloc/lstopo/images/2XeonE5v3.v1.11.png
> On AMD EPYC, you even have up to 8 LLC per package.

Right, I missed the fact that x86 reports a different cpumask for
topology_core_cpumask() which defines the core_siblings exported through
sysfs than the mask used to define MC level in the scheduler topology.
The sysfs core_siblings is defined by the package_id, while the MC level
is defined by the LLC.

Thanks for pointing this out.

On arm64 MC level and sysfs core_siblings are currently defined using
the same mask, but we can't break sysfs, so using different masks is the
only option.

Morten 
