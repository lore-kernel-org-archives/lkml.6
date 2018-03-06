Return-Path: <sudeep.holla@arm.com>
X-Google-Smtp-Source: AG47ELs7cfpDkHr/C6J/ca3NikIrMiDrmvX5JcyPc/8A++AbXc2AZpFG+1FEYL5zZYaKrETdlwhU
ARC-Seal: i=1; a=rsa-sha256; t=1520357970; cv=none;
        d=google.com; s=arc-20160816;
        b=H33sXcaF8ZvmBWGPNh60ySm/Jma1g0cr5Oga6Or/nKSl69AuRk6sQzMV7dciZgnXKY
         /FGraiOSM4uKQ5yj2djnB1LbhNTq6ePuWSqnHYjCMLChaJYWyrRgdcpz3qNHfka76250
         UglvhH2/tXN91ar0DNmyXFCDQw7nPMasxkOkpTkRiJ9XIWOcaXT3gBgfluoqrX54IUrE
         FIwdEftmmhcY4qPZDNA8DdngcztYF962G9l5vTdh4cmSkQWJoJ3jMV0mNZhlHv4MnU2A
         PyRb3C+mtfce1AaSH6oUaZ7D6OD3+jXJxOhO6W1ulgGygMza3UMmAmGBTFLIv2Lyymxx
         xuWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:organization:from:references:to:subject
         :cc:arc-authentication-results;
        bh=XscGi4x+LNpVcKosCc31zEvnjA1lnq1QVcOwNNgjJao=;
        b=qzPOVjN5ZYSe/MwlRwh5JOBCs5Vhc1KYUF26uPUsR8GTMU2no0qHTLwpsTKt6mk/6n
         o784ZMkFIs7ahPkfTlLcpvt7i78UjojcVrjMjobOKt5QL04Us71d0sdZLaeLrVhtEiuT
         NTlnwLJdPfpnDI5uBI4P5sUyUCllCTHWUQ49uikqzyoIPgID28tOaOAL9GOG8DqGjsY+
         1ksf7oFl2g+Kax1zgGf9wHB7ASePY2oUb3zSOks978FyEPCE6WBrT4fXxEEXRiBPIWQR
         pi2WeBCSJNJpsg/pfLvEZPldQ6Y11uZyHdDwFPJseKmokb6kWCprP4oOXUeZRq3PcH5n
         hnQA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of sudeep.holla@arm.com designates 217.140.101.70 as permitted sender) smtp.mailfrom=sudeep.holla@arm.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of sudeep.holla@arm.com designates 217.140.101.70 as permitted sender) smtp.mailfrom=sudeep.holla@arm.com
Cc: Sudeep Holla <sudeep.holla@arm.com>,
 linux-arm-kernel@lists.infradead.org, lorenzo.pieralisi@arm.com,
 hanjun.guo@linaro.org, rjw@rjwysocki.net, will.deacon@arm.com,
 catalin.marinas@arm.com, gregkh@linuxfoundation.org, mark.rutland@arm.com,
 linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
 wangxiongfeng2@huawei.com, vkilari@codeaurora.org, ahs3@redhat.com,
 dietmar.eggemann@arm.com, morten.rasmussen@arm.com, palmer@sifive.com,
 lenb@kernel.org, john.garry@huawei.com, austinwc@codeaurora.org,
 tnowicki@caviumnetworks.com
Subject: Re: [PATCH v7 05/13] ACPI/PPTT: Add Processor Properties Topology
 Table parsing
To: Jeremy Linton <jeremy.linton@arm.com>, linux-acpi@vger.kernel.org
References: <20180228220619.6992-1-jeremy.linton@arm.com>
 <20180228220619.6992-6-jeremy.linton@arm.com>
From: Sudeep Holla <sudeep.holla@arm.com>
Organization: ARM
Message-ID: <56b96eaa-4c9d-7661-1ed0-df34c9c1e636@arm.com>
Date: Tue, 6 Mar 2018 17:39:24 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180228220619.6992-6-jeremy.linton@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593684148891338280?=
X-GMAIL-MSGID: =?utf-8?q?1594210879555959804?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>



On 28/02/18 22:06, Jeremy Linton wrote:
> ACPI 6.2 adds a new table, which describes how processing units
> are related to each other in tree like fashion. Caches are
> also sprinkled throughout the tree and describe the properties
> of the caches in relation to other caches and processing units.
> 
> Add the code to parse the cache hierarchy and report the total
> number of levels of cache for a given core using
> acpi_find_last_cache_level() as well as fill out the individual
> cores cache information with cache_setup_acpi() once the
> cpu_cacheinfo structure has been populated by the arch specific
> code.
> 
> An additional patch later in the set adds the ability to report
> peers in the topology using find_acpi_cpu_topology()
> to report a unique ID for each processing unit at a given level
> in the tree. These unique id's can then be used to match related
> processing units which exist as threads, COD (clusters
> on die), within a given package, etc.
> 
> 
The more I look at the ACPI table parsing code, I get more questions
every time :). So I just skimmed through it this time. Not sure why
ACPI_PTR_* is not used elsewhere in drivers/acpi/tables.c

Anyways for cacheinfo part of this file:

Acked-by: Sudeep Holla <sudeep.holla@arm.com>

-- 
Regards,
Sudeep
