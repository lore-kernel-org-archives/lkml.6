Return-Path: <SRS0=E8pv=NX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3E6EC43441
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 15:42:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6C3F420817
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 15:42:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6C3F420817
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729412AbeKMBgb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 20:36:31 -0500
Received: from mga02.intel.com ([134.134.136.20]:33994 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726981AbeKMBgb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 20:36:31 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 12 Nov 2018 07:42:44 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,495,1534834800"; 
   d="scan'208";a="105573925"
Received: from djiang5-mobl2.amr.corp.intel.com (HELO [10.254.53.21]) ([10.254.53.21])
  by fmsmga004.fm.intel.com with ESMTP; 12 Nov 2018 07:42:44 -0800
Subject: Re: [PATCH 02/11] libnvdimm/security: change clear text nvdimm keys
 to encrypted keys
To:     Mimi Zohar <zohar@linux.ibm.com>,
        Dan Williams <dan.j.williams@intel.com>
Cc:     Mimi Zohar <zohar@linux.vnet.ibm.com>,
        linux-nvdimm <linux-nvdimm@lists.01.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        keyrings@vger.kernel.org
References: <154180093865.70506.6858789591063128903.stgit@djiang5-desk3.ch.intel.com>
 <154180163666.70506.8805433934495072699.stgit@djiang5-desk3.ch.intel.com>
 <1541957268.3734.53.camel@linux.ibm.com>
 <CAPcyv4jMPDap8L6jTo9NGnrJGCjUY_BvSBuPge8NL4QS2Ku0CQ@mail.gmail.com>
 <1541966975.3734.78.camel@linux.ibm.com>
From:   Dave Jiang <dave.jiang@intel.com>
Message-ID: <bf917ee9-1795-9c10-ecec-28c7d5d68345@intel.com>
Date:   Mon, 12 Nov 2018 08:42:43 -0700
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <1541966975.3734.78.camel@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 11/11/2018 1:09 PM, Mimi Zohar wrote:
>>> Traditionally there is a single master key for the system, which would
>>> be sealed to a set of boot time PCR values.  After decrypting all of
>>> the encrypted keys, the master key would be removed from the keyring
>>> and a PCR extended.  Extending a PCR would prevent the master key from
>>> being unsealed again and used to decrypt encrypted keys, without
>>> rebooting the system.  Normally this would be done before pivoting
>>> root.
>>>
>>> If you're not referring to the system master key and are intentionally
>>> limiting usage to TPM 2.0, more details on the master key security
>>> requirements should be included.
>> Oh, interesting point. I think we had been assuming a local +
>> unsealed-at-runtime nvdimm master key rather than a system-wide master
>> key. Yes, we need to rethink this in terms of supporting a sealed
>> system-key. This would seem to limit security actions, outside of
>> unlock, to always requiring a reboot. I.e. the nominal case is that we
>> boot up and unlock the DIMMs, but any subsequent security operation
>> like erase, or change-passphrase would require rebooting into an
>> environment where the system-master key is unsealed. I do think
>> re-provisioning keys and erasing DIMM contents are sufficiently
>> exceptional events that a reboot requirement is tolerable.
>> Is there already existing tooling around this to be able to schedule
>> master-key related actions to be deferred to an initrd environment?
> There's the original dracut support for loading a masterkey, which is
> used by the EVM and ecryptfs dracut modules.  After the last usage,
> the masterkey needs to be removed from the keyring.

How does one generate new encrypted keys with the system masterkey 
removed from the keyring?


>
> Different people over the years have wanted to add support for
> calculating the boot time expected PCRs values in order to reseal keys
> (trusted key update), but I haven't looked to see if there are any
> open source tools available.
>
> Mimi
>
