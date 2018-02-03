Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752533AbeBCO26 (ORCPT <rfc822;w@1wt.eu>);
        Sat, 3 Feb 2018 09:28:58 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:52828 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751972AbeBCO2u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Feb 2018 09:28:50 -0500
Subject: Re: [PATCH v2 2/2] HID: core: Fix size as type u32
To: Marcus Folkesson <marcus.folkesson@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-input@vger.kernel.org,
        jikos@kernel.org, benjamin.tissoires@redhat.com
References: <20180108024141.10590-1-aaron.ma@canonical.com>
 <20180108024141.10590-2-aaron.ma@canonical.com>
 <20180203075531.GA707@gmail.com>
From: Aaron Ma <aaron.ma@canonical.com>
Message-ID: <27dd1296-8422-e123-b5c6-b28141bd270c@canonical.com>
Date: Sat, 3 Feb 2018 22:28:41 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.2
MIME-Version: 1.0
In-Reply-To: <20180203075531.GA707@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/03/2018 03:55 PM, Marcus Folkesson wrote:
> Hi Aaron,
> 
> On Mon, Jan 08, 2018 at 10:41:41AM +0800, Aaron Ma wrote:
>> When size is negative, calling memset will make segment fault.
>> Declare the size as type u32 to keep memset safe.
>>
>> size in struct hid_report is unsigned, fix return type of
>> hid_report_len to u32.
>>
>> Cc: stable@vger.kernel.org
>> Signed-off-by: Aaron Ma <aaron.ma@canonical.com>
>> ---
>>  drivers/hid/hid-core.c | 10 +++++-----
>>  include/linux/hid.h    |  6 +++---
>>  2 files changed, 8 insertions(+), 8 deletions(-)
>>
>> diff --git a/drivers/hid/hid-core.c b/drivers/hid/hid-core.c
>> index 0c3f608131cf..cf81c53e3b98 100644
>> --- a/drivers/hid/hid-core.c
>> +++ b/drivers/hid/hid-core.c
>> @@ -1390,7 +1390,7 @@ u8 *hid_alloc_report_buf(struct hid_report *report, gfp_t flags)
>>  	 * of implement() working on 8 byte chunks
>>  	 */
>>  
>> -	int len = hid_report_len(report) + 7;
>> +	u32 len = hid_report_len(report) + 7;
>>  
>>  	return kmalloc(len, flags);
>>  }
>> @@ -1455,7 +1455,7 @@ void __hid_request(struct hid_device *hid, struct hid_report *report,
>>  {
>>  	char *buf;
>>  	int ret;
>> -	int len;
>> +	u32 len;
>>  
>>  	buf = hid_alloc_report_buf(report, GFP_KERNEL);
>>  	if (!buf)
>> @@ -1481,14 +1481,14 @@ void __hid_request(struct hid_device *hid, struct hid_report *report,
>>  }
>>  EXPORT_SYMBOL_GPL(__hid_request);
>>  
>> -int hid_report_raw_event(struct hid_device *hid, int type, u8 *data, int size,
>> +int hid_report_raw_event(struct hid_device *hid, int type, u8 *data, u32 size,
>>  		int interrupt)
>>  {
>>  	struct hid_report_enum *report_enum = hid->report_enum + type;
>>  	struct hid_report *report;
>>  	struct hid_driver *hdrv;
>>  	unsigned int a;
>> -	int rsize, csize = size;
>> +	u32 rsize, csize = size;
>>  	u8 *cdata = data;
>>  	int ret = 0;
>>  
>> @@ -1546,7 +1546,7 @@ EXPORT_SYMBOL_GPL(hid_report_raw_event);
>>   *
>>   * This is data entry for lower layers.
>>   */
>> -int hid_input_report(struct hid_device *hid, int type, u8 *data, int size, int interrupt)
>> +int hid_input_report(struct hid_device *hid, int type, u8 *data, u32 size, int interrupt)
>>  {
>>  	struct hid_report_enum *report_enum;
>>  	struct hid_driver *hdrv;
>> diff --git a/include/linux/hid.h b/include/linux/hid.h
>> index d491027a7c22..9bc296eebc98 100644
>> --- a/include/linux/hid.h
>> +++ b/include/linux/hid.h
>> @@ -841,7 +841,7 @@ extern int hidinput_connect(struct hid_device *hid, unsigned int force);
>>  extern void hidinput_disconnect(struct hid_device *);
>>  
>>  int hid_set_field(struct hid_field *, unsigned, __s32);
>> -int hid_input_report(struct hid_device *, int type, u8 *, int, int);
>> +int hid_input_report(struct hid_device *, int type, u8 *, u32, int);
>>  int hidinput_find_field(struct hid_device *hid, unsigned int type, unsigned int code, struct hid_field **field);
>>  struct hid_field *hidinput_get_led_field(struct hid_device *hid);
>>  unsigned int hidinput_count_leds(struct hid_device *hid);
>> @@ -1088,13 +1088,13 @@ static inline void hid_hw_wait(struct hid_device *hdev)
>>   *
>>   * @report: the report we want to know the length
>>   */
>> -static inline int hid_report_len(struct hid_report *report)
>> +static inline u32 hid_report_len(struct hid_report *report)
> hid_report_len() is used in several files.
> If we think it is a good idea to change the return type, we should fix
> these files as well.
> 
> [08:47:56]marcus@little:~/git/linux$ git grep -l hid_report_len
> drivers/hid/hid-core.c
> drivers/hid/hid-input.c
> drivers/hid/hid-multitouch.c
> drivers/hid/hid-rmi.c
> drivers/hid/usbhid/hid-core.c
> drivers/hid/wacom_sys.c
> drivers/staging/greybus/hid.c
> include/linux/hid.h


Sure, I will fix these return type in a new patch.

Thanks,
Aaron


> 
>>  {
>>  	/* equivalent to DIV_ROUND_UP(report->size, 8) + !!(report->id > 0) */
>>  	return ((report->size - 1) >> 3) + 1 + (report->id > 0);
>>  }
>>  
>> -int hid_report_raw_event(struct hid_device *hid, int type, u8 *data, int size,
>> +int hid_report_raw_event(struct hid_device *hid, int type, u8 *data, u32 size,
>>  		int interrupt);
>>  
>>  /* HID quirks API */
>> -- 
>> 2.14.3
> Best regards
> Marcus Folkesson
