Return-Path: <SRS0=kQMq=PK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 721D9C43387
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Jan 2019 20:20:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2DD5C2171F
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Jan 2019 20:20:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F2ZmcHcI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726718AbfABUUh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Jan 2019 15:20:37 -0500
Received: from mail-ed1-f67.google.com ([209.85.208.67]:45706 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726009AbfABUUg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Jan 2019 15:20:36 -0500
Received: by mail-ed1-f67.google.com with SMTP id d39so27189387edb.12;
        Wed, 02 Jan 2019 12:20:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=j4+3vTeKmxVtxYqZdZFhf8nc09KCLy9pGkfWnOHlBvU=;
        b=F2ZmcHcIcrSSkCZ+5iaSB9Y3eKiJPsylLFAEmMMZGNs5a7Rh/UnvnsXbcdqPHijRY0
         EdmfEBmhy8cDwLYeMX5FNwZmaCw2fjXmu7kyMT75UYYLRjYbcl1c/RJQY/zIkmQjoGzr
         mqA7r9JPhgUT00VE5sslMOgQbsUOkUcU2UYDFPQlDJ5wlRL7ojLLTT47tR22XXCZgRW3
         myROfRTq3lXfQ2b9SHby3q1MWpwIUeC4UDzVfoY5cOdm/RRoPV+SEz194b86pZ0U3AY6
         L4M6rmYbkwDC81Zw5oGCDl0pepM/5NY3zCr6ZrDXMKDw+Y2QnZtJvBU/+TmWXochOxHK
         0L7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=j4+3vTeKmxVtxYqZdZFhf8nc09KCLy9pGkfWnOHlBvU=;
        b=TPYIeZikatYGaWukB53DVX7otg0o9UlG38MemHQGI/TxepL5jqsH5DSAKN2JPpt28l
         l+tv6zed1MG9QfcCWOy0/LwrWSMMjLs21nNZINY8biSQHnRqqWseUBzxy0PhHe0rhJ0H
         MGFaD2NVtIGuvs8pYxUzSh3PQ/0DJK9KE1x4NC2E2w++BjJmhlyb7XCTfZ6vloX+7mh0
         PwhnXAg/TJeOV6nl54rgndgGe4I0joemt/HxTKUJ9vO7tpYWENGpBtt1PQjGn5BI4q96
         fF6/bshh4p39R+bsxzjKD8fsPgp06J4nx4aBjQgrH+ulLhAM01/NpQrA9h/iM9HT/E7R
         MiUA==
X-Gm-Message-State: AA+aEWbjiLGuc1raJAmZWc/xZhUqJ2BUNHjfoWM8PhDWvBqHFpljAUqz
        ne3Vdwi8aeq5hNippTIbTfQ=
X-Google-Smtp-Source: AFSGD/UKKorszS1/nhBb8LL0dvXLgVeJAkPp/3v/tzTzB2zjYeFBOc46OYlrGXhRJlV3l++bpx7Cww==
X-Received: by 2002:a50:94f4:: with SMTP id t49mr40955353eda.24.1546460434747;
        Wed, 02 Jan 2019 12:20:34 -0800 (PST)
Received: from eldamar (80-218-24-251.dclient.hispeed.ch. [80.218.24.251])
        by smtp.gmail.com with ESMTPSA id h11-v6sm12372404ejc.3.2019.01.02.12.20.33
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 02 Jan 2019 12:20:33 -0800 (PST)
Date:   Wed, 2 Jan 2019 21:20:32 +0100
From:   Salvatore Bonaccorso <carnil@debian.org>
To:     Steven Sistare <steven.sistare@oracle.com>
Cc:     Dominique Martinet <asmadeus@codewreck.org>,
        Pavel Tatashin <pavel.tatashin@microsoft.com>,
        daniel.m.jordan@oracle.com, linux@armlinux.org.uk,
        schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com,
        john.stultz@linaro.org, sboyd@codeaurora.org, x86@kernel.org,
        linux-kernel@vger.kernel.org, mingo@redhat.com, tglx@linutronix.de,
        hpa@zytor.com, douly.fnst@cn.fujitsu.com, peterz@infradead.org,
        prarit@redhat.com, feng.tang@intel.com, pmladek@suse.com,
        gnomes@lxorguk.ukuu.org.uk, linux-s390@vger.kernel.org,
        boris.ostrovsky@oracle.com, jgross@suse.com, pbonzini@redhat.com,
        virtualization@lists.linux-foundation.org, kvm@vger.kernel.org,
        qemu-devel@nongnu.org
Subject: Re: [PATCH v15 23/26] sched: early boot clock
Message-ID: <20190102202032.GA1034@eldamar.local>
References: <20180719205545.16512-1-pasha.tatashin@oracle.com>
 <20180719205545.16512-24-pasha.tatashin@oracle.com>
 <20181106054212.GA31768@nautica>
 <95c3920e-bf80-0c7e-7854-01a1c3189c23@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <95c3920e-bf80-0c7e-7854-01a1c3189c23@oracle.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, Nov 06, 2018 at 06:35:36AM -0500, Steven Sistare wrote:
> Pavel has a new email address, cc'd - steve
> 
> On 11/6/2018 12:42 AM, Dominique Martinet wrote:
> > (added various kvm/virtualization lists in Cc as well as qemu as I don't
> > know who's "wrong" here)
> > 
> > Pavel Tatashin wrote on Thu, Jul 19, 2018:
> >> Allow sched_clock() to be used before schec_clock_init() is called.
> >> This provides with a way to get early boot timestamps on machines with
> >> unstable clocks.
> > 
> > This isn't something I understand, but bisect tells me this patch
> > (landed as 857baa87b64 ("sched/clock: Enable sched clock early")) makes
> > a VM running with kvmclock take a step in uptime/printk timer early in
> > boot sequence as illustrated below. The step seems to be related to the
> > amount of time the host was suspended while qemu was running before the
> > reboot.
> > 
> > $ dmesg
> > ...
> > [    0.000000] SMBIOS 2.8 present.
> > [    0.000000] DMI: QEMU Standard PC (i440FX + PIIX, 1996), BIOS ?-20180724_192412-buildhw-07.phx2.fedoraproject.org-1.fc29 04/01/2014
> > [    0.000000] Hypervisor detected: KVM
> > [    0.000000] kvm-clock: Using msrs 4b564d01 and 4b564d00
> > [283120.529821] kvm-clock: cpu 0, msr 321a8001, primary cpu clock
> > [283120.529822] clocksource: kvm-clock: mask: 0xffffffffffffffff max_cycles: 0x1cd42e4dffb, max_idle_ns: 881590591483 ns
> > [283120.529824] tsc: Detected 2592.000 MHz processor
> > ...
> > 
> > (The VM is x86_64 on x86_64, I can provide my .config on request but
> > don't think it's related)
> > 
> > 
> > It's rather annoying for me as I often reboot VMs and rely on the
> > 'uptime' command to check if I did just reboot or not as I have the
> > attention span of a goldfish; I'd rather not have to find something else
> > to check if I did just reboot or not.
> > 
> > Note that if the qemu process is restarted, there is no offset anymore.
> > 
> > I unfortunately just did that so cannot say with confidence (putting my
> > laptop to sleep for 30s only led to a 2s offset and I do not want to
> > wait longer right now), but it looks like the clock is still mostly
> > correct after reboot after disabling my VM's ntp client. Will infirm
> > that tomorrow if I was wrong.
> > 
> > 
> > Happy to try to help fixing this in any way, as written above the quote
> > I'm not even actually sure who is wrong here.

A user in Debian reported the same/similar issue (with 4.19.13):

https://bugs.debian.org/918036

Regards,
Salvatore
