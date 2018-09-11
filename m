Return-Path: <SRS0=LZPJ=LZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.4 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,URIBL_SBL,URIBL_SBL_A,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DE3BC04ABB
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 23:54:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A94742087F
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 23:54:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jAkrbRz3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A94742087F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728007AbeILEzq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Sep 2018 00:55:46 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:45277 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726009AbeILEzp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Sep 2018 00:55:45 -0400
Received: by mail-pg1-f193.google.com with SMTP id x26-v6so33705pge.12;
        Tue, 11 Sep 2018 16:54:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=/2kIOkMGv0CPxPFSMPMOQaZZ49DgAsqaZSYSgnw68wY=;
        b=jAkrbRz32pS+EPZO41wX/gjzDbsaDwnyHymSCS/4s3YlF2xv1v12NGbOs8IIP37hgz
         0NZRxFjEg5MWCDOY4Nb9sC6dmdo1Y2zgJZtomxStrugwnZxxd43Htual6wQoIu0w8412
         af7al+0XZr5i8tcpAvhWjwvTAbFWoYFYOFiYMBqg2U5jRbP2H9esQKS7P3DkQ1YaW4gR
         9zaYlGfKLz8Od9IQcPWxDr/zuRALraTig6nI+oRXnLvDEeE3I+ez8UauOqmHyKgtoJGS
         N8myJB+iUrTEEle/N2ztP1/6ac1czgeUXwqhqOTVvnwoGOUmz6FvSCgfGYOLOyWxhPTC
         jPrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=/2kIOkMGv0CPxPFSMPMOQaZZ49DgAsqaZSYSgnw68wY=;
        b=pulVaFN0Xg3xfPUkG0XScI//5eY/PAvAwJwQpXAhFlnXbFDkF7UNcmAkqpmad2LQ3S
         CgWYQ0omQUrMWgG80wmR078iSrRiZPfwFRcTJlU8iXtw+AVEksiNY2UGp4/SaulJUwxe
         LrUU5fQjXHdY0Zff9DBe8c9upczNuGErHzsEYNa/ep+Op9STApXX8DDLfBx6cd+4Z9KX
         vE+gOrQPhLf2WD/gVwJuoHlWULpf81HQ8bajV0ycbpeb0HywS0kpmOrFre3hBMSymoXc
         rup+NFP+0qO09JbtPeW6MireoF4FC2tydBuhIHpn7WmEUz2Ri/jRGHpuNIpKjY4NVrGl
         zq2g==
X-Gm-Message-State: APzg51DOBu3JdL5VwulYTQOZTa/Ue+V+7zoaRxwLLz0M4XLNi9oMtcA/
        rVaoa4Mw+xsK5V4zQQwMp6Y=
X-Google-Smtp-Source: ANB0VdbSAADsxlE9Z5PLwYFk/tduSbE4D3u/HOajGnK8OnkMc+DdeAYuneTVPgOnk0XBahp4ZwULlQ==
X-Received: by 2002:a63:1644:: with SMTP id 4-v6mr30604617pgw.103.1536710045992;
        Tue, 11 Sep 2018 16:54:05 -0700 (PDT)
Received: from localhost (108-223-40-66.lightspeed.sntcca.sbcglobal.net. [108.223.40.66])
        by smtp.gmail.com with ESMTPSA id r64-v6sm31578691pfk.157.2018.09.11.16.54.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 11 Sep 2018 16:54:04 -0700 (PDT)
Date:   Tue, 11 Sep 2018 16:54:03 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     David Howells <dhowells@redhat.com>
Cc:     viro@zeniv.linux.org.uk, torvalds@linux-foundation.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH 14/33] vfs: Implement a filesystem superblock
 creation/configuration context [ver #11]
Message-ID: <20180911235403.GA10107@roeck-us.net>
References: <20180911220743.GA13208@roeck-us.net>
 <20180911174641.GA15149@roeck-us.net>
 <153313703562.13253.5766498657900728120.stgit@warthog.procyon.org.uk>
 <153313714181.13253.304098108512966976.stgit@warthog.procyon.org.uk>
 <27113.1536702746@warthog.procyon.org.uk>
 <32382.1536707855@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <32382.1536707855@warthog.procyon.org.uk>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 12, 2018 at 12:17:35AM +0100, David Howells wrote:
> Guenter Roeck <linux@roeck-us.net> wrote:
> 
> > [    8.507672] RIP: 0010:reconfigure_super+0x47/0x210
> 
> Can you tell me the file and line this corresponds to?
> 
I don't know, but some debugging shows that fc->ops == NULL.

Guenter
