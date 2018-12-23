Return-Path: <SRS0=rRkv=PA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADD04C43387
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Dec 2018 04:10:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 74D46218F0
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Dec 2018 04:10:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="HJHwT/gy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393162AbeLWEKO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 22 Dec 2018 23:10:14 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:49784 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731916AbeLWEKO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Dec 2018 23:10:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Transfer-Encoding
        :Content-Type:MIME-Version:References:Message-ID:Subject:To:From:Date:Sender:
        Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=pFGzrJT4y8xTDieFHiQv+XAQHOHdPO8JpsbzG13rY8c=; b=HJHwT/gy48Ti4x3haQw55MJfFC
        j/3bYryesdlIXBs7xaU786tf0W0eqIn+OKChj3mL8n5OsSUGU9M3ePVNWp1IJTNc9+tkYTgqJsbjP
        yyQ1NqRTpaDGNV6cLcwdGEoNy+LbMh/e9SJLUiMwvbRS3SjakDy5KLw72ewbsp+sFF7DWiEekWIpX
        dclDMsP1ZrM/7fCkR4pLE4Ge+XPb6wThGmgeG4N2E5nvCJQs7lEeA6TJ2S0C3itmAE32wzAGYH0ZL
        MW1oATO2wkl5eVzxtZp1DL2O8Ahqi8qed2yVZjslOqDkmY2TDiYoBFWLBUIeenExwOn0O7qBuRPPl
        u3045xMw==;
Received: from willy by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gav5b-0007qG-Ul; Sun, 23 Dec 2018 04:10:07 +0000
Date:   Sat, 22 Dec 2018 20:10:07 -0800
From:   Matthew Wilcox <willy@infradead.org>
To:     "Theodore Y. Ts'o" <tytso@mit.edu>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Christoph Hellwig <hch@infradead.org>,
        Dave Chinner <david@fromorbit.com>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Eric Biggers <ebiggers@kernel.org>,
        linux-fscrypt@vger.kernel.org,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-ext4@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
        linux-integrity@vger.kernel.org,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        Victor Hsieh <victorhsieh@google.com>,
        Chandan Rajendra <chandan@linux.vnet.ibm.com>
Subject: Re: [PATCH v2 01/12] fs-verity: add a documentation file
Message-ID: <20181223041007.GL10600@bombadil.infradead.org>
References: <20181219071420.GC2628@infradead.org>
 <20181219021953.GD31274@dastard>
 <20181219193005.GB6889@mit.edu>
 <20181219213552.GO6311@dastard>
 <20181220220158.GC2360@mit.edu>
 <20181221070447.GA21687@infradead.org>
 <20181221154714.GA26547@mit.edu>
 <CAHk-=wgdzWgoPSuHeVcqmGE1hB3Gan72r2_AhtC14e60=z45yg@mail.gmail.com>
 <20181222041712.GC26547@mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20181222041712.GC26547@mit.edu>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 21, 2018 at 11:17:12PM -0500, Theodore Y. Ts'o wrote:
> Userspace applications which are reading the file aren't going to be
> expecting Merkle tree.  For example, one of the use cases is Android
> APK files, which are essentially ZIP files.  ZIP files can be parsed
> both from the front-end (streaming), or by looking for the complete
> directory of all of the files in the ZIP file by starting at the end
> of the file and moving backwards.  If the Merkle tree was visible to
> userspace programs that are opening and reading the file, it would
> confuse them mightily.

Pretty much every file format has the ability to put arbitrary blocks
of information into a file somewhere the tools which don't know about
it will skip it.  For example, ZIP "includes an extra field facility
within file headers, which can be used to store extra data not defined
by existing ZIP specifications, and which allow compliant archivers that
do not recognize the fields to safely skip them. Header IDs 0–31 are
reserved for use by PKWARE. The remaining IDs can be used by third-party
vendors for proprietary usage. " (Wikipedia)

ELF, PNG, PDF and many other formats have the ability to put data
_somewhere_.  It might not be at the tail of the file, but there's
somewhere to do it.

(I appreciate this isn't what Linus is asking for, but I'm pointing out
that this is by no means as intractable as you make it sound.)

