Return-Path: <SRS0=TO5I=LL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A1ABC433F5
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 18:09:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A38A12087C
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 18:09:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="p/uy/vUd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A38A12087C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727404AbeH1WCm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Aug 2018 18:02:42 -0400
Received: from merlin.infradead.org ([205.233.59.134]:45364 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727130AbeH1WCm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Aug 2018 18:02:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=REEDdhcsjfFTLS48PMY65npoDqqE8e6fTQGykuUYbXo=; b=p/uy/vUdi0Oqsz66KHCHmvsHpp
        geT3MdCGVHs038pCh7a8uf7tsxlGVaGPkUVuBqjrU91+VBg6iICi4a9RsJUhfl51BMhXO7OhUPRlB
        sVcMCBY7TteVgrtObcKEecYIvwiAwHA+pE5wOYqz3yU4FCf7QA5HywgDnzAMxyVBvU0e3Q6HodA5P
        b1iBuv8Wwh9ohWmcFKoA1bWDsvriiUJfCUMhp/ygJB023J4HMB9I7Vu9PgxdaLCBuGxysbXILYj8A
        iSJCEFHZDrpIqnBL8M+xV/BMTZaesQWSQe7iGtCgBnAGGL1OwoH87BP4ZDBHOEsuNbzoaRWqWqM4e
        IQj7BFgg==;
Received: from static-50-53-52-16.bvtn.or.frontiernet.net ([50.53.52.16] helo=midway.dunlab)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fuiQv-0002Qh-Jn; Tue, 28 Aug 2018 18:09:44 +0000
Subject: Re: [PATCH v5 3/3] overlayfs: override_creds=off option bypass
 creator_cred
To:     Mark Salyzyn <salyzyn@android.com>, linux-kernel@vger.kernel.org
Cc:     Miklos Szeredi <miklos@szeredi.hu>,
        Jonathan Corbet <corbet@lwn.net>,
        Vivek Goyal <vgoyal@redhat.com>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        Amir Goldstein <amir73il@gmail.com>,
        Stephen Smalley <sds@tycho.nsa.gov>,
        linux-unionfs@vger.kernel.org, linux-doc@vger.kernel.org
References: <20180828165336.211643-1-salyzyn@android.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <a8dc66c4-4761-4876-abd3-6dc135692404@infradead.org>
Date:   Tue, 28 Aug 2018 11:09:39 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180828165336.211643-1-salyzyn@android.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/28/2018 09:53 AM, Mark Salyzyn wrote:
> diff --git a/Documentation/filesystems/overlayfs.txt b/Documentation/filesystems/overlayfs.txt
> index 72615a2c0752..953e52971eb0 100644
> --- a/Documentation/filesystems/overlayfs.txt
> +++ b/Documentation/filesystems/overlayfs.txt
> @@ -106,6 +106,35 @@ Only the lists of names from directories are merged.  Other content
>  such as metadata and extended attributes are reported for the upper
>  directory only.  These attributes of the lower directory are hidden.
>  
> +credentials
> +-----------
> +
> +By default, all access to the upper, lower and work directories is the
> +recorded mounter's MAC and DAC credentials.  The incoming accesses are
> +checked against the caller's credentials.
> +
> +If the principles of least privilege are applied, the mounter's
> +credentials might not overlap the credentials of the caller's when
> +accessing the overlayfs filesystem.  For example, a file that a lower
> +DAC privileged caller can execute, but is MAC denied to the
> +generally higher DAC privileged mounter, to prevent an attack vector
> +executing with the increased privileges of the mounter.  One option is
> +to turn off override_creds in the mount options; all subsequent
> +operations after mount on the filesystem will be only the caller's
> +credentials.  This option default is set in the CONFIG
> +OVERLAY_FS_OVERRIDE_CREDS or in the module option override_creds.
> +Fundamentally The mounter has privileges, its ability to execute,

                 the

but this entire sentence is jumbled and awkward and could use some work.
I tried to come up with something but I can't quite get what is intended here.


> +for example, files and grant them these higher privileges is to be
> +blocked except to lower privileged and appropriate callers.  This
> +option turned off permits this kind of security policy.
> +
> +With override_creds turned off, several unintended side effects will
> +occur.  The caller with a lower privilege will not be able to delete
> +files or directories, create nodes, or search some directories.  The
> +uneven security model where upperdir and workdir are opened at
> +privilege, but accessed without, should only be used with strict
> +understanding of the side effects and of the security policies.
> +
>  whiteouts and opaque directories
>  --------------------------------


-- 
~Randy
