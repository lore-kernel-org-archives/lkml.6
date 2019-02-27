Return-Path: <SRS0=HyMZ=RC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C16AC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 05:33:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6E36D218CD
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 05:33:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726747AbfB0Fds (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Feb 2019 00:33:48 -0500
Received: from mga18.intel.com ([134.134.136.126]:35513 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725903AbfB0Fds (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Feb 2019 00:33:48 -0500
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 26 Feb 2019 21:33:47 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,418,1544515200"; 
   d="scan'208";a="146888280"
Received: from richard.sh.intel.com (HELO localhost) ([10.239.159.54])
  by fmsmga002.fm.intel.com with ESMTP; 26 Feb 2019 21:33:46 -0800
Date:   Wed, 27 Feb 2019 13:33:19 +0800
From:   Wei Yang <richardw.yang@linux.intel.com>
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     Wei Yang <richardw.yang@linux.intel.com>, qemu-devel@nongnu.org,
        linux-kernel@vger.kernel.org, somlo@cmu.edu
Subject: Re: [PATCH] fw_cfg: use __ATTR_RO_MODE to define rev sysfs
Message-ID: <20190227053319.GB5449@richard>
Reply-To: Wei Yang <richardw.yang@linux.intel.com>
References: <20190226073159.13434-1-richardw.yang@linux.intel.com>
 <20190226110934-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190226110934-mutt-send-email-mst@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 26, 2019 at 11:10:06AM -0500, Michael S. Tsirkin wrote:
>On Tue, Feb 26, 2019 at 03:31:59PM +0800, Wei Yang wrote:
>> Leverage __ATTR_RO_MODE to define rev sysfs instead of using open code
>> to define the attribute.
>> 
>> Signed-off-by: Wei Yang <richardw.yang@linux.intel.com>
>> ---
>>  drivers/firmware/qemu_fw_cfg.c | 13 ++++---------
>>  1 file changed, 4 insertions(+), 9 deletions(-)
>> 
>> diff --git a/drivers/firmware/qemu_fw_cfg.c b/drivers/firmware/qemu_fw_cfg.c
>> index 039e0f91dba8..a1293cbd7adb 100644
>> --- a/drivers/firmware/qemu_fw_cfg.c
>> +++ b/drivers/firmware/qemu_fw_cfg.c
>> @@ -296,18 +296,13 @@ static int fw_cfg_do_platform_probe(struct platform_device *pdev)
>>  	return 0;
>>  }
>>  
>> -static ssize_t fw_cfg_showrev(struct kobject *k, struct attribute *a, char *buf)
>> +static ssize_t fw_cfg_rev_show(struct kobject *k, struct kobj_attribute *a,
>> +			       char *buf)
>>  {
>>  	return sprintf(buf, "%u\n", fw_cfg_rev);
>>  }
>> -
>> -static const struct {
>> -	struct attribute attr;
>> -	ssize_t (*show)(struct kobject *k, struct attribute *a, char *buf);
>> -} fw_cfg_rev_attr = {
>> -	.attr = { .name = "rev", .mode = S_IRUSR },
>> -	.show = fw_cfg_showrev,
>> -};
>> +static const struct kobj_attribute fw_cfg_rev_attr =
>> +	__ATTR_RO_MODE(fw_cfg_rev, 0400);
>>  
>>  /* fw_cfg_sysfs_entry type */
>>  struct fw_cfg_sysfs_entry {
>
>
>Looks like this will change the name from "rev" to "fw_cfg_rev".
>That's a userspace visible change which we should not do lightly.

You are right, I should keep the interface untouched.

To keep it user un-visible, we could change like below:

-       __ATTR_RO(fw_cfg_rev);
+       __ATTR_RO(rev);

Is this better for you?

>> -- 
>> 2.19.1

-- 
Wei Yang
Help you, Help me
