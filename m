Return-Path: <SRS0=1Lvk=PY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E320CC43612
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 20:37:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AFA3D206C2
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 20:37:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cAS31M3W"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729887AbfAPUhR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Jan 2019 15:37:17 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:38751 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726778AbfAPUhQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jan 2019 15:37:16 -0500
Received: by mail-pf1-f194.google.com with SMTP id q1so3625046pfi.5;
        Wed, 16 Jan 2019 12:37:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=PKeM13okA+sfXBgaFGeAUoLT1IxUEg+314kRtlSCWww=;
        b=cAS31M3WMCw7SjA8+LYXwq/6XtbkKQCwCR8d4wqY9yNDH7OBhI4nYowARkE4LbZdF9
         GSrBCsiYNPgO0C29ybgN08MWZHhfPo/IOEsuQcdGUCFBhOX8SnfZp0dc0einxcp8efvc
         bg1/DBnez0yhm7TDjFqeGdC6ty07HOpQpMSV9Q8kKwwht/0ygUc79GG1mP8ETn576iu7
         ljscLvG57mG8JX4H1xmKdG+lydMdcco1KEd2db/KV9DW9eQeV6xvms2MsGlp5E8HfFrM
         0VPtgVEwU1/l3+TIszfO3kWRLmeqwLivucAtZlUDKpAO8M/yXP8Za1INFoxEIckkMJzO
         VZ5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=PKeM13okA+sfXBgaFGeAUoLT1IxUEg+314kRtlSCWww=;
        b=lRMTPinZ2WGNdTIWD1kXI7m9jqnPrGPyz5D+up5+VrdAzcq3BNSYBPv4TaE6oY0CsS
         1tcAJ+I8OvaXfIa/+cJC/SAVxF9vYgsA9Ct8FkkGhSQr4QTcUEBzC7AnJP+HrrBkOoRJ
         NUtjz3CSAXhyGb6P11Hkjoma2VFaV9BrUZBK2OUnGrL6uqClVKH9hYTvxsmcPiY1z4Yl
         rrHap4nA5EYngpW7wvfiX0rpptCEZlFasGVbZ3X0jQdriOo4LTER1VGRxR2s5XY784Jr
         OXd7Vplhj7Nua3+V00g/T4UNyx7na7H86sMh2QnnAfl8c+IHbyK+uq7HLlhBaVg1Kbil
         2qRw==
X-Gm-Message-State: AJcUukebO4vR8TatM8f864EnuzRN2yPBaXtyFrSF5rjx3zRJo7D4SK27
        CW1idGkR5lpD0MCiXe1UQMw=
X-Google-Smtp-Source: ALg8bN52/ADcslExc2gmHh4/6FortU02xfuN089rexDhZpNN3QvmYxc7EiKQxPzaKVBOGZdPwq6lWQ==
X-Received: by 2002:a63:f30d:: with SMTP id l13mr10621091pgh.399.1547671035750;
        Wed, 16 Jan 2019 12:37:15 -0800 (PST)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id h69sm7949604pge.4.2019.01.16.12.37.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 16 Jan 2019 12:37:15 -0800 (PST)
Date:   Wed, 16 Jan 2019 12:37:14 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
Subject: Re: [PATCH 4.9 00/16] 4.9.151-stable review
Message-ID: <20190116203714.GB1302@roeck-us.net>
References: <20190115154848.164648613@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190115154848.164648613@linuxfoundation.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 15, 2019 at 05:35:43PM +0100, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.9.151 release.
> There are 16 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu Jan 17 15:48:25 UTC 2019.
> Anything received after that time might be too late.
> 

Build results:
	total: 172 pass: 172 fail: 0
Qemu test results:
	total: 315 pass: 315 fail: 0

Guenter
