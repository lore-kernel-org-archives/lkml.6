Return-Path: <SRS0=Mdfq=OF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A45BAC43610
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 18:14:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 77F2820855
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 18:14:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 77F2820855
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726456AbeK0FJg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Nov 2018 00:09:36 -0500
Received: from lhrrgout.huawei.com ([185.176.76.210]:32783 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725723AbeK0FJg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Nov 2018 00:09:36 -0500
Received: from LHREML712-CAH.china.huawei.com (unknown [172.18.7.108])
        by Forcepoint Email with ESMTP id 87087E6116621;
        Mon, 26 Nov 2018 18:14:38 +0000 (GMT)
Received: from [10.204.65.144] (10.204.65.144) by smtpsuk.huawei.com
 (10.201.108.35) with Microsoft SMTP Server (TLS) id 14.3.408.0; Mon, 26 Nov
 2018 18:14:34 +0000
Subject: Re: [RFC][PATCH] fs: set xattrs in initramfs from regular files
To:     Rob Landley <rob@landley.net>, <viro@zeniv.linux.org.uk>
CC:     <linux-fsdevel@vger.kernel.org>, <linux-integrity@vger.kernel.org>,
        <linux-security-module@vger.kernel.org>,
        <initramfs@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <zohar@linux.ibm.com>, <silviu.vlasceanu@huawei.com>,
        <dmitry.kasatkin@huawei.com>, <takondra@cisco.com>,
        <kamensky@cisco.com>, <hpa@zytor.com>, <arnd@arndb.de>,
        <james.w.mcmechan@gmail.com>
References: <20181122154942.18262-1-roberto.sassu@huawei.com>
 <7f2b0288-a173-e2bb-70ee-d552610bfc1e@landley.net>
 <b907b5ca-1515-1ed4-d50d-28c1736c0eb8@huawei.com>
 <79a41125-0232-6f6e-6f38-f4c45a7b439e@landley.net>
From:   Roberto Sassu <roberto.sassu@huawei.com>
Message-ID: <a343bbde-f27f-2c62-1843-5c86460e4352@huawei.com>
Date:   Mon, 26 Nov 2018 19:14:34 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.0
MIME-Version: 1.0
In-Reply-To: <79a41125-0232-6f6e-6f38-f4c45a7b439e@landley.net>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.204.65.144]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/26/2018 6:42 PM, Rob Landley wrote:
> On 11/26/18 6:56 AM, Roberto Sassu wrote:
>> On 11/23/2018 9:21 PM, Rob Landley wrote:
>>>> The aim of this patch is to provide the same functionality without
>>>> introducing a new format. The value of xattrs is placed in regular files
>>>> having the same file name as the files xattrs are added to, plus a
>>>> separator and the xattr name (<filename>.xattr-<xattr name>).
>>>
>>> I think you're solving the wrong problem, but that's just my opinion.
>>
>> Instead of iterating over rootfs, would it be better to detect files
>> with extended attributes (from the file name) when the cpio image is
>> parsed by the kernel,
> 
> Huh, I thought at first glance that's what the new approach _was_ doing.
> 
> In band signaling in the archive is ugly, still requires new tools to create it,

For SElinux, the changes would be minimal. Instead of adding the
xattr, setfiles would create a regular file with the suffix, in the
temporary directory containing the files to be added to the CPIO image.

For IMA, I think there is also a tool to write file signatures. It
shouldn't be a problem to do the same modification I proposed for
SELinux.


> doesn't address the y2038 issue... (Although we could cheat, treat the time
> signature as unsigned, and buy another few decades.)
> 
> But doing that in the filesystem _after_ you extract the archive is beyond ugly.
> 
>> and call sys_lsetxattr() in do_copy()? This part
>> can be turned on by introducing a new type in the existing format (if
>> possible).
>>
>> The impact of this alternative is very low, and LSMs/IMA would be able,
>> with minimum effort, to enforce policies on files in the initial ram
>> disk.
> 
> The cpio extension isn't a big deal, I was pondering doing it myself in toybox
> (and submitting a kernel patch to consume the output) before Mimi approached me.
> (I did the initmpfs stuff already, I've stomped around in this area before.) I
> just didn't because mimi sent their patch first, so I waited for that to work
> its way though.
> 
> Unfortunately, it's simple enough that there was a bit of bikeshedding. (You can
> store time in milliseconds as a 64 bit number without worrying about the range,
> but if you do it as nanoseconds you need two fields, but people spoke up and
> said "but if you don't store the nanoseconds the rounding causes spurious time
> differences when between filesystems and it confuses our build system about what
> has and hasn't changed"...)
> 
> The new in-band signaling proposal is, at best, a hack. (Filename lengths are
> capped at 255 in the VFS, can you strip the xattrs on a long filename by having
> the extension fail to create in the filesystem? Or do you have an arbitrary max
> length on filenames because you need to reserve room for the extension?)

Yes, that would be a limitation. Alternatively, files with xattrs could
be placed in a subdir. For example:

/bin/cat
/bin/.xattr-<xattr name>/cat

Roberto


> Rob
> 

-- 
HUAWEI TECHNOLOGIES Duesseldorf GmbH, HRB 56063
Managing Director: Bo PENG, Jian LI, Yanli SHI
