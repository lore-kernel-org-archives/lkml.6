Return-Path: <SRS0=zRJA=NN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A90AC32789
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 07:27:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CB1B52082D
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 07:27:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CB1B52082D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728076AbeKBQd1 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Nov 2018 12:33:27 -0400
Received: from prv1-mh.provo.novell.com ([137.65.248.33]:49132 "EHLO
        prv1-mh.provo.novell.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725843AbeKBQd1 (ORCPT
        <rfc822;groupwise-linux-kernel@vger.kernel.org:5:1>);
        Fri, 2 Nov 2018 12:33:27 -0400
Received: from INET-PRV1-MTA by prv1-mh.provo.novell.com
        with Novell_GroupWise; Fri, 02 Nov 2018 01:27:15 -0600
Message-Id: <5BDBFC1402000078001F7101@prv1-mh.provo.novell.com>
X-Mailer: Novell GroupWise Internet Agent 18.0.2 
Date:   Fri, 02 Nov 2018 01:26:12 -0600
From:   "Jan Beulich" <JBeulich@suse.com>
To:     "Juergen Gross" <jgross@suse.com>
Cc:     "Stefano Stabellini" <sstabellini@kernel.org>,
        "xen-devel" <xen-devel@lists.xenproject.org>,
        "Boris Ostrovsky" <boris.ostrovsky@oracle.com>,
        <linux-kernel@vger.kernel.org>, <stable@vger.kernel.org>
Subject: Re: [Xen-devel] [PATCH] xen: remove size limit of privcmd-buf
 mapping interface
References: <20181101123307.8424-1-jgross@suse.com>
 <5BDB0B240200007800142507@prv1-mh.provo.novell.com>
 <b64f7fa4-a553-bcb4-6051-c91080642b8e@suse.com>
 <5BDB20AB020000780014251B@suse.com>
 <12dd8625-2cad-f156-8bae-487e909af412@suse.com>
In-Reply-To: <12dd8625-2cad-f156-8bae-487e909af412@suse.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>>> On 01.11.18 at 17:27, <jgross@suse.com> wrote:
> On 01/11/2018 16:50, Jan Beulich wrote:
>>>>> Juergen Gross <jgross@suse.com> 11/01/18 3:23 PM >>>
>>> On 01/11/2018 15:18, Jan Beulich wrote:
>>>>>>> Juergen Gross <jgross@suse.com> 11/01/18 1:34 PM >>>
>>>>> Currently the size of hypercall buffers allocated via
>>>>> /dev/xen/hypercall is limited to a default of 64 memory pages. For live
>>>>> migration of guests this might be too small as the page dirty bitmask
>>>>> needs to be sized according to the size of the guest. This means
>>>>> migrating a 8GB sized guest is already exhausting the default buffer
>>>>> size for the dirty bitmap.
>>>>>
>>>>> There is no sensible way to set a sane limit, so just remove it
>>>>> completely. The device node's usage is limited to root anyway, so there
>>>>> is no additional DOS scenario added by allowing unlimited buffers.
>>>>
>>>> But is this setting of permissions what we want long term? What about a
>>>> de-privileged qemu, which still needs to be able to issue at least dm-op
>>>> hypercalls?
>>>
>>> Wouldn't that qemu have opened the node while still being privileged?
>> 
>> Possibly, but how does this help? As soon as it's unprivileged it must not
>> be able to hog resources anymore.
>> 
>> Anyway, with Andrew's reply my point may be irrelevant, but I have to
>> admit I'm not entirely sure.
> 
> I guess we want Xen tools to close /dev/xen/hypercall (or more precise:
> don't dup2() it) when qemu is de-privileging itself. This will make it
> very clear that it can't hog memory via mmap().
> 
> When you are fine with that I'll send a Xen patch for this.

If that doesn't prevent the process from making the hypercalls it
is permitted to do (I have to admit I don't recall if there are any
still needed besides the dmop ones), sure.

Jan


