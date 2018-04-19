Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753536AbeDSOTK (ORCPT <rfc822;w@1wt.eu>);
        Thu, 19 Apr 2018 10:19:10 -0400
Received: from mail-ot0-f195.google.com ([74.125.82.195]:41704 "EHLO
        mail-ot0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752679AbeDSOTF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Apr 2018 10:19:05 -0400
X-Google-Smtp-Source: AIpwx48o5XPvFjxr7BhdEZBjeSkQQkX6c5NGVDfg+RoFFPP2Wg50/xk4+kJFy2caIlWHLDWX7jxTpg==
Subject: Re: [RFC PATCH v2 2/4] acpi: apei: Split GHES handlers outside of
 ghes_do_proc
To: Borislav Petkov <bp@alien8.de>
Cc: linux-acpi@vger.kernel.org, linux-edac@vger.kernel.org,
        rjw@rjwysocki.net, lenb@kernel.org, tony.luck@intel.com,
        tbaicar@codeaurora.org, will.deacon@arm.com, james.morse@arm.com,
        shiju.jose@huawei.com, zjzhang@codeaurora.org, gengdongjiu@huawei.com,
        linux-kernel@vger.kernel.org, alex_gagniuc@dellteam.com,
        austin_bolen@dell.com, shyam_iyer@dell.com, devel@acpica.org,
        mchehab@kernel.org, robert.moore@intel.com, erik.schmauss@intel.com
References: <20180416215903.7318-1-mr.nuke.me@gmail.com>
 <20180416215903.7318-3-mr.nuke.me@gmail.com> <20180418175201.GI4795@pd.tnic>
From: "Alex G." <mr.nuke.me@gmail.com>
Message-ID: <5f26275c-5896-c552-69c4-78e5aaaa6558@gmail.com>
Date: Thu, 19 Apr 2018 09:19:03 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180418175201.GI4795@pd.tnic>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 04/18/2018 12:52 PM, Borislav Petkov wrote:
> On Mon, Apr 16, 2018 at 04:59:01PM -0500, Alexandru Gagniuc wrote:
>>  static void ghes_do_proc(struct ghes *ghes,
>>  			 const struct acpi_hest_generic_status *estatus)
>>  {
>>  	int sev, sec_sev;
>>  	struct acpi_hest_generic_data *gdata;
>> +	const struct ghes_handler *handler;
>>  	guid_t *sec_type;
>>  	guid_t *fru_id = &NULL_UUID_LE;
>>  	char *fru_text = "";
>> @@ -478,21 +537,10 @@ static void ghes_do_proc(struct ghes *ghes,
>>  		if (gdata->validation_bits & CPER_SEC_VALID_FRU_TEXT)
>>  			fru_text = gdata->fru_text;
>>  
>> -		if (guid_equal(sec_type, &CPER_SEC_PLATFORM_MEM)) {
>> -			struct cper_sec_mem_err *mem_err = acpi_hest_get_payload(gdata);
>> -
>> -			ghes_edac_report_mem_error(sev, mem_err);
>> -
>> -			arch_apei_report_mem_error(sev, mem_err);
>> -			ghes_handle_memory_failure(gdata, sev);
>> -		}
>> -		else if (guid_equal(sec_type, &CPER_SEC_PCIE)) {
>> -			ghes_handle_aer(gdata);
>> -		}
>> -		else if (guid_equal(sec_type, &CPER_SEC_PROC_ARM)) {
>> -			struct cper_sec_proc_arm *err = acpi_hest_get_payload(gdata);
>>  
>> -			log_arm_hw_error(err);
>> +		handler = get_handler(sec_type);
> 
> I don't like this - it was better and more readable before because I can
> follow which handler gets called. This change makes is less readable.

I agree with the readability argument in the current situation of three
handlers. I guess I was thinking ahead and generalizing for an arbitrary
number of handlers.

On the other side, you lose readability as soon as you get a few more
handlers and the function becomes too long. And more importantly, you
lose generality: it's not obvious that there's
ghes_edac_report_mem_error() which too wide a context.

Alex
