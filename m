Return-Path: <SRS0=LZPJ=LZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76262C04ABB
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 18:14:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 396882086A
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 18:14:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 396882086A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=codethink.co.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728143AbeIKXOm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Sep 2018 19:14:42 -0400
Received: from imap1.codethink.co.uk ([176.9.8.82]:50421 "EHLO
        imap1.codethink.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726689AbeIKXOm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Sep 2018 19:14:42 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126] helo=xylophone)
        by imap1.codethink.co.uk with esmtpsa (Exim 4.84_2 #1 (Debian))
        id 1fznAu-0008EX-Ey; Tue, 11 Sep 2018 19:14:08 +0100
Message-ID: <1536689647.3024.129.camel@codethink.co.uk>
Subject: Re: [PATCH 4.4 22/79] Smack: Mark inode instant in
 smack_task_to_inode
From:   Ben Hutchings <ben.hutchings@codethink.co.uk>
To:     Casey Schaufler <casey@schaufler-ca.com>,
        James Morris <james.morris@microsoft.com>
Cc:     stable@vger.kernel.org,
        Sasha Levin <alexander.levin@microsoft.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        LKML <linux-kernel@vger.kernel.org>
Date:   Tue, 11 Sep 2018 19:14:07 +0100
In-Reply-To: <20180823074920.150267602@linuxfoundation.org>
References: <20180823074918.641878835@linuxfoundation.org>
         <20180823074920.150267602@linuxfoundation.org>
Organization: Codethink Ltd.
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.6-1+deb9u1 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2018-08-23 at 09:52 +0200, Greg Kroah-Hartman wrote:
> 4.4-stable review patch.  If anyone has any objections, please let me know.
> 
> ------------------
> 
> From: Casey Schaufler <casey@schaufler-ca.com>
> 
> [ Upstream commit 7b4e88434c4e7982fb053c49657e1c8bbb8692d9 ]
> 
> Smack: Mark inode instant in smack_task_to_inode
> 
> /proc clean-up in commit 1bbc55131e59bd099fdc568d3aa0b42634dbd188

That change ("/proc clean-up") only went into 4.18 and hasn't been
backported to stable, so does this make sense for earlier stable
branches?

Ben.

> resulted in smack_task_to_inode() being called before smack_d_instantiate.
> This resulted in the smk_inode value being ignored, even while present
> for files in /proc/self. Marking the inode as instant here fixes that.
> 
> Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
> Signed-off-by: James Morris <james.morris@microsoft.com>
> Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> ---
>  security/smack/smack_lsm.c |    1 +
>  1 file changed, 1 insertion(+)
> 
> --- a/security/smack/smack_lsm.c
> +++ b/security/smack/smack_lsm.c
> @@ -2260,6 +2260,7 @@ static void smack_task_to_inode(struct t
>  	struct smack_known *skp = smk_of_task_struct(p);
>  
>  	isp->smk_inode = skp;
> +	isp->smk_flags |= SMK_INODE_INSTANT;
>  }
>  
>  /*
> 
> 
> 
-- 
Ben Hutchings, Software Developer                         Codethink Ltd
https://www.codethink.co.uk/                 Dale House, 35 Dale Street
                                     Manchester, M1 2HF, United Kingdom
