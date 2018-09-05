Return-Path: <SRS0=wmYC=LT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8074FC433F5
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 22:20:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CB9532083D
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 22:20:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CB9532083D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ZenIV.linux.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727827AbeIFCwZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Sep 2018 22:52:25 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:34194 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727657AbeIFCwZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Sep 2018 22:52:25 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.87 #1 (Red Hat Linux))
        id 1fxg9d-00059p-Ca; Wed, 05 Sep 2018 22:20:05 +0000
Date:   Wed, 5 Sep 2018 23:20:05 +0100
From:   Al Viro <viro@ZenIV.linux.org.uk>
To:     David Howells <dhowells@redhat.com>
Cc:     linux-api@vger.kernel.org, linux-kbuild@vger.kernel.org,
        Ryusuke Konishi <konishi.ryusuke@lab.ntt.co.jp>,
        linux-nilfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 07/11] UAPI: nilfs2: Fix use of undefined byteswapping
 functions
Message-ID: <20180905222005.GS19965@ZenIV.linux.org.uk>
References: <153616286704.23468.584491117180383924.stgit@warthog.procyon.org.uk>
 <153616292366.23468.14988166998690800938.stgit@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <153616292366.23468.14988166998690800938.stgit@warthog.procyon.org.uk>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 05, 2018 at 04:55:23PM +0100, David Howells wrote:
>  nilfs_checkpoint_set_##name(struct nilfs_checkpoint *cp)		\
>  {									\
> -	cp->cp_flags = cpu_to_le32(le32_to_cpu(cp->cp_flags) |		\
> +	cp->cp_flags = __cpu_to_le32(__le32_to_cpu(cp->cp_flags) |	\
>  				   (1UL << NILFS_CHECKPOINT_##flag));	\

How about sanitiziung the damn thing to
	cp->cp_flags |= __cpu_to_le32(1UL << NILFS_CHECKPOINT_##flag));

while you are at it?  Or, perhaps, even
#define NILFS2_CP_FLAG(flag) __cpu_to_le32(1UL << NILFS_CHECKPOINT_##flag)

and cp->cp_flags |= NILFS2_CP_FLAG(flag) for this one,

>  }									\
>  static inline void							\
>  nilfs_checkpoint_clear_##name(struct nilfs_checkpoint *cp)		\
>  {									\
> -	cp->cp_flags = cpu_to_le32(le32_to_cpu(cp->cp_flags) &		\
> +	cp->cp_flags = __cpu_to_le32(__le32_to_cpu(cp->cp_flags) &	\
>  				   ~(1UL << NILFS_CHECKPOINT_##flag));	\
	cp->cp_flags &= ~NILFS2_CP_FLAG(flag);
here

>  }									\
>  static inline int							\
>  nilfs_checkpoint_##name(const struct nilfs_checkpoint *cp)		\
>  {									\
> -	return !!(le32_to_cpu(cp->cp_flags) &				\
> +	return !!(__le32_to_cpu(cp->cp_flags) &				\
>  		  (1UL << NILFS_CHECKPOINT_##flag));			\

and !!(cp->cp_flags & NILFS2_CP_FLAG(flag)
here?  Or maybe even make the damn thing bool and lose the !! here...

)>  }
>  

and similar for those:

> @@ -595,20 +596,20 @@ enum {
>  static inline void							\
>  nilfs_segment_usage_set_##name(struct nilfs_segment_usage *su)		\
>  {									\
> -	su->su_flags = cpu_to_le32(le32_to_cpu(su->su_flags) |		\
> +	su->su_flags = __cpu_to_le32(__le32_to_cpu(su->su_flags) |	\
>  				   (1UL << NILFS_SEGMENT_USAGE_##flag));\
>  }									\
>  static inline void							\
>  nilfs_segment_usage_clear_##name(struct nilfs_segment_usage *su)	\
>  {									\
>  	su->su_flags =							\
> -		cpu_to_le32(le32_to_cpu(su->su_flags) &			\
> +		__cpu_to_le32(__le32_to_cpu(su->su_flags) &		\
>  			    ~(1UL << NILFS_SEGMENT_USAGE_##flag));      \
>  }									\
>  static inline int							\
>  nilfs_segment_usage_##name(const struct nilfs_segment_usage *su)	\
>  {									\
> -	return !!(le32_to_cpu(su->su_flags) &				\
> +	return !!(__le32_to_cpu(su->su_flags) &				\
>  		  (1UL << NILFS_SEGMENT_USAGE_##flag));			\
>  }



> @@ -619,15 +620,15 @@ NILFS_SEGMENT_USAGE_FNS(ERROR, error)
>  static inline void
>  nilfs_segment_usage_set_clean(struct nilfs_segment_usage *su)
>  {
> -	su->su_lastmod = cpu_to_le64(0);
> -	su->su_nblocks = cpu_to_le32(0);
> -	su->su_flags = cpu_to_le32(0);
> +	su->su_lastmod = __cpu_to_le64(0);
> +	su->su_nblocks = __cpu_to_le32(0);
> +	su->su_flags = __cpu_to_le32(0);
>  }
>  
>  static inline int
>  nilfs_segment_usage_clean(const struct nilfs_segment_usage *su)
>  {
> -	return !le32_to_cpu(su->su_flags);
> +	return !__le32_to_cpu(su->su_flags);

"Check that after byteswap it becomes 0", is it?  How is that different
from return !su->su_flags; ?
