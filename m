Return-Path: <SRS0=Jh2l=L4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E69CDFC6182
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 16:21:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A06922146E
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 16:21:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="WJNW/Z5I"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A06922146E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728324AbeINVg5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Sep 2018 17:36:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:38236 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726900AbeINVg5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Sep 2018 17:36:57 -0400
Received: from sol.localdomain (c-67-185-97-198.hsd1.wa.comcast.net [67.185.97.198])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EDC2A2083A;
        Fri, 14 Sep 2018 16:21:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1536942105;
        bh=l/MtbRycAf5F2mkJ/Zzh+1W2fM7r4fKUik1yNIhWp8M=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=WJNW/Z5IdCRRz5aSWS/XHrqiOqjq3mlUEroI/13F5CjcLIbIMc8V9AkEx4puthRli
         OMYrExa8N+0X3ogoHPrcX0fSq9OxdzjVahN2NLTsA5dXBhc8petNm2iV2MEI8DdZyu
         vQSB2xvcxPdJBY/ysLRWDQxCmugePEllfZ+xx4KM=
Date:   Fri, 14 Sep 2018 09:21:43 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     Colin Walters <walters@verbum.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net,
        linux-integrity@vger.kernel.org, linux-fscrypt@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Mimi Zohar <zohar@linux.vnet.ibm.com>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        Michael Halcrow <mhalcrow@google.com>,
        Victor Hsieh <victorhsieh@google.com>
Subject: Re: [RFC PATCH 01/10] fs-verity: add setup code, UAPI, and Kconfig
Message-ID: <20180914162142.GA734@sol.localdomain>
References: <20180824161642.1144-1-ebiggers@kernel.org>
 <20180824161642.1144-2-ebiggers@kernel.org>
 <1535132549.2855027.1485213752.129E3334@webmail.messagingengine.com>
 <20180825044852.GB726@sol.localdomain>
 <1536930930.1003187.1508104496.6465C44D@webmail.messagingengine.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1536930930.1003187.1508104496.6465C44D@webmail.messagingengine.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Colin,

On Fri, Sep 14, 2018 at 09:15:30AM -0400, Colin Walters wrote:
> On Sat, Aug 25, 2018, at 12:48 AM, Eric Biggers wrote:
> >
> > As Ted pointed out, only truncates are denied on fs-verity files, not other
> > metadata changes like chmod().
> > 
> > Think of it this way: the purpose of fs-verity is *not* to make files immutable.
> > It's to hash them.
> 
> Sorry for my unfamiliarity with Android internals but - in earlier discussion
> I believe it was mentioned that APK (zip files?) that are being targeted here, right?
> 
> Now AIUI, Zip files have an internal header that contains e.g. the size and
> indexes into the internal files.  So if someone added random data to the end
> of a zip file, nothing is going to end up actually reading it.
> 
> However, there are file formats that use the size of the file reported by stat();
> at least OSTree does this with serializing GVariant.  I'm sure there are others -
> I'd imagine at least some things parsing ELF do this?
> In such a case, we really want to deny appending to the file as well.
> 
> Unless there's some mechanism to deny applications reading not-verified
> data?
> 
> And "hidden" data after fs-verity protected files would be a nice place
> for persistent malware to hide.
> 
> Does anyone know of a use case for appending to a fs-verity file?
> 
> The slides here:
> https://events.linuxfoundation.org/wp-content/uploads/2017/11/fs-verify_Mike-Halcrow_Eric-Biggers.pdf
> even say "File becomes read-only!"
> 
> If not, then here's a strawman: Require that at FS_IOC_ENABLE_VERITY time
> the file does not have any +w bits set (and I guess no ACLs that do so...
> that may get ugly).  
> 
> I think that would make it easier to later factor out a "_CONTENTS_IMMUTABLE"
> flag.
> 

After the verity bit is enabled, the verity metadata is not visible to
userspace.  Yes, that means i_size is adjusted too.  Also all contents
modifications are denied, including appends.

- Eric
