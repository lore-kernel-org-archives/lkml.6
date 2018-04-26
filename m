Return-Path: <sudeep.holla@arm.com>
X-Google-Smtp-Source: AIpwx4//Clvbw5fLNNAPWSN3lDN2vUykZd1IXVn8Alv3FTg4Ow4MjLBDiSlNDr9AorjlcTI94O7B
ARC-Seal: i=1; a=rsa-sha256; t=1524738429; cv=none;
        d=google.com; s=arc-20160816;
        b=aFZihN24ecUJFB2bczZiL42Z0dpqIS+KMTNdeCLiyO3dItqZPw6JeATZt+DKSerjPl
         MZ8iWsyCSt9i2PTbBvmTYkv60Mprugvw8HPBGPD7xhiOe/FgdS63zytJu4++99F5DlOo
         iWrDKDDddQmEF3puf8zQoKvrwKqXHtDS+TPOrqPFl+uEI+Rde5OJ/8eNfwqU+qyxgghg
         RmQNlOSeGq/qJLMJPVhwerttZXD+4IEPSXCjgS5obp0PWL9FS7Ak/4af8yvCknDo+D7j
         S1xnAhk4YSLPGinu79dOcDLXgc7YMBpRkBDcPEgZFbVqqeThsQUxwZox6lj7rFg12g6K
         U2UQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:organization:from:references:to:subject
         :cc:arc-authentication-results;
        bh=hBqdvvj4z3+WZRtEAJXpa1j7ixpilZ6lf6fmejuLAx8=;
        b=LUOMtc8YVGkyoI5H/a4mh99QTNhu54URdaEiSGOfVE80sm2iNnZcRLBMHXpssJzJX8
         VitFTL+qqHLVA5kwSAWcf3lf4Q9mVOTs2KG61Kf7HFcmaA1ccWTpRwejie6e2nHwMlHG
         vaPhFZwphmx4ceggMCVo3LCCN/XgMBvKndVepd4NO9QNbHlehyAGIgudIr80xUembmu9
         mrLBf5A3gmH2m6HoVd9jy30nIfozevEzVsnwt9qUwWbvRdiAUSQ7olGuKVReS6LF0EpA
         Tb87teD7YqJgHbRDan777tnNfj9/y7g4qou3uILhq5ruA/dCA0bXmWULs9sVjQBcxo4c
         B1sw==
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
Subject: Re: [PATCH v8 04/13] arm64/acpi: Create arch specific cpu to acpi id
 helper
To: Jeremy Linton <jeremy.linton@arm.com>, linux-acpi@vger.kernel.org
References: <20180425233121.13270-1-jeremy.linton@arm.com>
 <20180425233121.13270-5-jeremy.linton@arm.com>
From: Sudeep Holla <sudeep.holla@arm.com>
Organization: ARM
Message-ID: <16324b54-42d4-d9bc-6d57-de52431dc209@arm.com>
Date: Thu, 26 Apr 2018 11:27:01 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180425233121.13270-5-jeremy.linton@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598766316038693524?=
X-GMAIL-MSGID: =?utf-8?q?1598804123576877499?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>



On 26/04/18 00:31, Jeremy Linton wrote:
> Its helpful to be able to lookup the acpi_processor_id associated
> with a logical cpu. Provide an arm64 helper to do this.
> 

As I pointed out in the earlier version, this patch is not required.
The acpi_id stored in the acpi_processor can be used for this.
Won't the below change make it work ? I can't think of any reason why it
shouldn't.

Regards,
Sudeep

-->8

diff --git i/drivers/acpi/pptt.c w/drivers/acpi/pptt.c
index 0fc4b2654665..f421f58b4ae6 100644
--- i/drivers/acpi/pptt.c
+++ w/drivers/acpi/pptt.c
@@ -432,7 +432,7 @@ static void cache_setup_acpi_cpu(struct
acpi_table_header *table,
 {
        struct acpi_pptt_cache *found_cache;
        struct cpu_cacheinfo *this_cpu_ci = get_cpu_cacheinfo(cpu);
-       u32 acpi_cpu_id = get_acpi_id_for_cpu(cpu);
+       u32 acpi_cpu_id = per_cpu(processors, cpu)->acpi_id;
        struct cacheinfo *this_leaf;
        unsigned int index = 0;
        struct acpi_pptt_processor *cpu_node = NULL;
