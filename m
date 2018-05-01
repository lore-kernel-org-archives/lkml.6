Return-Path: <sudeep.holla@arm.com>
X-Google-Smtp-Source: AB8JxZojf6gv2d2LMBJEv3OnFbHpYR8xIgUy+p/3FHpgHIivCVm9X3IxI5KjcvJo3UWpzaPxhW/B
ARC-Seal: i=1; a=rsa-sha256; t=1525185991; cv=none;
        d=google.com; s=arc-20160816;
        b=es337UiLrohtIFXcXJcnM2niKY10mHR4bAAtSOpSp+bpyiHbUUjOLczI4JOQrR26PO
         cIWG8+OAfmg70/1I3prS5Fac4R+tiMe0wfeEfPXUMcYdYcXDPGn8X26h7F9mj1aIqMpt
         rlbNOz1nVI2/Zt0bbuCaBHnBt/XHDg9xgGwhxb/q1q6HL9lU68d3Awy02A7Nb/JQ8dAT
         KJsuvavj4U1UCLetg8Xq83enaA84PJJPswtmz5MoY4WELqg9/xP8UAq/7yDbYhJjbYwY
         5OAL7Ox+LeSB1aZwlIH/cvVHTcuhvW+6KwiT3kB6s29e2m0VU0vrJ4ZTmSoWAxiTUOC8
         zkDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:organization:from:references:to:subject
         :cc:arc-authentication-results;
        bh=TLPBJbbTX2RGW/g4PAfA75QFGwfgMxhxL0Cb3r4jCt8=;
        b=dFzKc+fqmiv71Y8zV/iCbw8o6eB82n3+4mOAgM6MWWc2jfxxRHo4BuOPfj5rvIjKiB
         mzG1uem/Q6qrCL8JZXztjmDnNqu5MUx3QcZ7IUXusWxZE/fVDMxUDZR9iGiGW/Rqa2PG
         AUUhiPCyI2TwAv1sqEltqtm7mmCxICdkaAvzZ4wmHoEfW4CL1WZrSYDBQTeV+mlXTkhH
         M+4ZF/KcGyIkpFQk1584MRxv2m1DV8XVwuVB+oS25Fb6uvulQ+MVdF5UDga3DOYDNO3t
         PvxgLLIU1AKtDJWu/By37mN1xQivGliohgyQQpINM1RPfSTf9kekESTW2oF858YEl0UF
         WtUw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of sudeep.holla@arm.com designates 217.140.101.70 as permitted sender) smtp.mailfrom=sudeep.holla@arm.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of sudeep.holla@arm.com designates 217.140.101.70 as permitted sender) smtp.mailfrom=sudeep.holla@arm.com
Cc: Sudeep Holla <sudeep.holla@arm.com>,
 linux-arm-kernel@lists.infradead.org, Lorenzo.Pieralisi@arm.com,
 hanjun.guo@linaro.org, rjw@rjwysocki.net, Will.Deacon@arm.com,
 Catalin.Marinas@arm.com, gregkh@linuxfoundation.org, Mark.Rutland@arm.com,
 linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
 wangxiongfeng2@huawei.com, vkilari@codeaurora.org, ahs3@redhat.com,
 Dietmar.Eggemann@arm.com, Morten.Rasmussen@arm.com, palmer@sifive.com,
 lenb@kernel.org, john.garry@huawei.com, austinwc@codeaurora.org,
 tnowicki@caviumnetworks.com, jhugo@qti.qualcomm.com, timur@qti.qualcomm.com,
 ard.biesheuvel@linaro.org
Subject: Re: [PATCH v8 11/13] arm64: topology: enable ACPI/PPTT based CPU
 topology
To: Jeremy Linton <jeremy.linton@arm.com>, linux-acpi@vger.kernel.org
References: <20180425233121.13270-1-jeremy.linton@arm.com>
 <20180425233121.13270-12-jeremy.linton@arm.com>
From: Sudeep Holla <sudeep.holla@arm.com>
Organization: ARM
Message-ID: <ab8357f0-61d5-2996-46ca-5bc5d3e097cf@arm.com>
Date: Tue, 1 May 2018 15:46:22 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180425233121.13270-12-jeremy.linton@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598766328036390506?=
X-GMAIL-MSGID: =?utf-8?q?1599273425959815991?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>



On 26/04/18 00:31, Jeremy Linton wrote:
> Propagate the topology information from the PPTT tree to the
> cpu_topology array. We can get the thread id and core_id by assuming
> certain levels of the PPTT tree correspond to those concepts.
> The package_id is flagged in the tree and can be found by calling
> find_acpi_cpu_topology_package() which terminates
> its search when it finds an ACPI node flagged as the physical
> package. If the tree doesn't contain enough levels to represent
> all of the requested levels then the root node will be returned
> for all subsequent levels.
> 

Acked-by: Sudeep Holla <sudeep.holla@arm.com>

[..]

> @@ -304,6 +345,8 @@ void __init init_cpu_topology(void)
>  	 * Discard anything that was parsed if we hit an error so we
>  	 * don't use partial information.
>  	 */
> -	if (of_have_populated_dt() && parse_dt_topology())
> +	if ((!acpi_disabled) && parse_acpi_topology())

[nit] not sure if extra () is need above, but I am fine either way.

-- 
Regards,
Sudeep
