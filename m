Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751445AbeBSGap (ORCPT <rfc822;w@1wt.eu>);
        Mon, 19 Feb 2018 01:30:45 -0500
Received: from mail-io0-f196.google.com ([209.85.223.196]:42992 "EHLO
        mail-io0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750988AbeBSGan (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Feb 2018 01:30:43 -0500
X-Google-Smtp-Source: AH8x224G6YAHB9nmviD2qjFqnbBZG7xxwJcGlEl7HKvGRyiGMma2RyzRImDDT911ios0gXlBTJpwDw==
Subject: Re: [PATCH v3 4/4] of: improve reporting invalid overlay target path
To: Rob Herring <robh@kernel.org>
Cc: pantelis.antoniou@konsulko.com,
        Pantelis Antoniou <panto@antoniou-consulting.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        geert@linux-m68k.org
References: <1518672946-7310-1-git-send-email-frowand.list@gmail.com>
 <1518672946-7310-5-git-send-email-frowand.list@gmail.com>
 <20180219032141.lapcr32f4zqulvvb@rob-hp-laptop>
From: Frank Rowand <frowand.list@gmail.com>
Message-ID: <b2bd1af4-1231-23d9-fd89-ad45d49d8257@gmail.com>
Date: Sun, 18 Feb 2018 22:30:40 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180219032141.lapcr32f4zqulvvb@rob-hp-laptop>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/18/18 19:21, Rob Herring wrote:
> On Wed, Feb 14, 2018 at 09:35:46PM -0800, frowand.list@gmail.com wrote:
>> From: Frank Rowand <frank.rowand@sony.com>
>>
>> Errors while developing the patch to create of_overlay_fdt_apply()
>> exposed inadequate error messages to debug problems when overlay
>> devicetree fragment nodes contain an invalid target path.  Improve
>> the messages in find_target_node() to remedy this.
>>
>> Signed-off-by: Frank Rowand <frank.rowand@sony.com>
>> ---
>>
>> changes from v2:
>>   - add fragment node name as suggested by Geert
>>   - existing error message printed short node name, thus not
>>     discriminating between fragments; change to full node name
>>   - existing error message printed node address, which is devicetree
>>     internal debugging, not useful in an overlay apply error message;
>>     remove node address from message
>>
>>  drivers/of/overlay.c | 22 ++++++++++++++++------
>>  1 file changed, 16 insertions(+), 6 deletions(-)
>>
>> diff --git a/drivers/of/overlay.c b/drivers/of/overlay.c
>> index 5f6c5569e97d..852e566d7744 100644
>> --- a/drivers/of/overlay.c
>> +++ b/drivers/of/overlay.c
>> @@ -488,20 +488,30 @@ static int build_changeset(struct overlay_changeset *ovcs)
>>   */
>>  static struct device_node *find_target_node(struct device_node *info_node)
>>  {
>> +	struct device_node *node;
>>  	const char *path;
>>  	u32 val;
>>  	int ret;
>>  
>>  	ret = of_property_read_u32(info_node, "target", &val);
>> -	if (!ret)
>> -		return of_find_node_by_phandle(val);
>> +	if (!ret) {
>> +		node = of_find_node_by_phandle(val);
>> +		if (!node)
>> +			pr_err("find target, node: %pOF, phandle 0x%x not found\n",
> 
> I'm wondering if the core should print the error rather than having all 
> the callers do it. The question is whether there are cases where failing 
> is okay? I guess sometimes we use 0 to skip cells, but the core handle 
> not printing an error in that case.

find_target_node() is overlay specific, and is only called from one location
in overlay.c.

There are no cases where failing is ok.  This is used to find the target
node that an overlay fragment is being applied to.  If it fails then
either the base devicetree or the overlay devicetree has an error.

-Frank


> Rob
> 
>> +			       info_node, val);
>> +		return node;
>> +	}
>>  
>>  	ret = of_property_read_string(info_node, "target-path", &path);
>> -	if (!ret)
>> -		return of_find_node_by_path(path);
>> +	if (!ret) {
>> +		node =  of_find_node_by_path(path);
>> +		if (!node)
>> +			pr_err("find target, node: %pOF, path '%s' not found\n",
>> +			       info_node, path);
>> +		return node;
>> +	}
>>  
>> -	pr_err("Failed to find target for node %p (%s)\n",
>> -		info_node, info_node->name);
>> +	pr_err("find target, node: %pOF, no target property\n", info_node);
>>  
>>  	return NULL;
>>  }
>> -- 
>> Frank Rowand <frank.rowand@sony.com>
>>
> 
