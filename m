Return-Path: <SRS0=kF4g=OX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 094E8C67839
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 01:45:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CA6D921473
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 01:45:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CA6D921473
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729031AbeLNBp4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Dec 2018 20:45:56 -0500
Received: from zeniv.linux.org.uk ([195.92.253.2]:54792 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728130AbeLNBp4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Dec 2018 20:45:56 -0500
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.91 #2 (Red Hat Linux))
        id 1gXcXs-0003OP-GP; Fri, 14 Dec 2018 01:45:40 +0000
Date:   Fri, 14 Dec 2018 01:45:40 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Ivan Delalande <colona@arista.com>
Cc:     Luis Chamberlain <mcgrof@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v2] proc/sysctl: don't return ENOMEM on lookup when a
 table is unregistering
Message-ID: <20181214014539.GO2217@ZenIV.linux.org.uk>
References: <20181213015742.GA28776@visor>
 <20181213065826.GL2217@ZenIV.linux.org.uk>
 <20181213232052.GA1513@visor>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181213232052.GA1513@visor>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 13, 2018 at 03:20:52PM -0800, Ivan Delalande wrote:

> @@ -474,7 +474,7 @@ static struct inode *proc_sys_make_inode(struct super_block *sb,
>  	if (unlikely(head->unregistering)) {
>  		spin_unlock(&sysctl_lock);
>  		iput(inode);
> -		inode = NULL;
> +		inode = ERR_PTR(-ENOENT);
>  		goto out;
>  	}

Applied, with one modification: if you look at the target of that goto,
you'll see
out:
        return inode;
so this place should be simply
 		spin_unlock(&sysctl_lock);
 		iput(inode);
		return ERR_PTR(-ENOENT);
	}

That way the label becomes unused and goes away.
