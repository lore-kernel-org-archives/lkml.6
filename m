Return-Path: <SRS0=sQLo=JB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,T_DKIMWL_WL_HIGH,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id ADEBFC5CFC1
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 14:28:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 55BE9208D7
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 14:28:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="1NTdp56O"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 55BE9208D7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965666AbeFOO2s (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Jun 2018 10:28:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:58346 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1756005AbeFOO2q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jun 2018 10:28:46 -0400
Received: from mail-wr0-f176.google.com (mail-wr0-f176.google.com [209.85.128.176])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 378E1208DA;
        Fri, 15 Jun 2018 14:28:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1529072925;
        bh=7B0pEF5B3fwrJOlsFPDiF9jJ+Spdjv+DKBF+LHO3oMU=;
        h=In-Reply-To:References:From:Date:Subject:To:Cc:From;
        b=1NTdp56O2yO6PAf1qPN/PihZzXT5dEUMJ3IAEJ1QKy5JN1gqVEG+QBBFK0D5bRAWj
         EiVhbLwbfYk0fbRIuSUGsQp0JxeU+nGqh9J+uJVh5LIbdi1FQ2uvnvlmtjtglPalbk
         HEjeLlwtpw1+UD7NQBbJ1Lj7NIZH6r2ysMubs6DQ=
Received: by mail-wr0-f176.google.com with SMTP id l10-v6so10162744wrn.2;
        Fri, 15 Jun 2018 07:28:45 -0700 (PDT)
X-Gm-Message-State: APt69E1qpdAdLcICp9b2kUpRVjjxPKzGKt5woYIgoWTCfp6LKvIoOs8x
        /T4LyjuIRFEduypOSQczNV5E0U9PUeV0jS4NMKU=
X-Google-Smtp-Source: ADUXVKJufao5yTzysIIBXXKNco7SpdoUpP9SQuAtLV9nSpiKKzcMTzv/cNzNwNmEcLFZRDLXLF/YAXPF/FUaNegqVVg=
X-Received: by 2002:a5d:4407:: with SMTP id z7-v6mr1978157wrq.227.1529072923665;
 Fri, 15 Jun 2018 07:28:43 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:adf:9166:0:0:0:0:0 with HTTP; Fri, 15 Jun 2018 07:28:43
 -0700 (PDT)
In-Reply-To: <BCD39D7E-EEEC-4EB9-824E-63323C333C88@oracle.com>
References: <CAJKOXPd2rntNOpU1quR9Zm_J22+=pEaj4ZTC_tdZ0zcRYUciFg@mail.gmail.com>
 <CAPKp9uZ79ybkv7dMpcy2GQ9L+rWk+vdExQ48diWWQPOUdDQtSQ@mail.gmail.com>
 <CAJKOXPfX0CytKcYDaDAYYuCQjk-mcGjFRHfZco-wPQsc4G1agA@mail.gmail.com> <BCD39D7E-EEEC-4EB9-824E-63323C333C88@oracle.com>
From:   Krzysztof Kozlowski <krzk@kernel.org>
Date:   Fri, 15 Jun 2018 16:28:43 +0200
X-Gmail-Original-Message-ID: <CAJKOXPcw-i99_U-Ltuuf6w-WRK7V4gNqVSYkCMGFEXQG2DL2XQ@mail.gmail.com>
Message-ID: <CAJKOXPcw-i99_U-Ltuuf6w-WRK7V4gNqVSYkCMGFEXQG2DL2XQ@mail.gmail.com>
Subject: Re: [BUG BISECT] NFSv4 client fails on Flush Journal to Persistent Storage
To:     Chuck Lever <chuck.lever@oracle.com>
Cc:     Sudeep Holla <sudeep.holla@arm.com>,
        Trond Myklebust <trond.myklebust@primarydata.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        Bruce Fields <bfields@fieldses.org>,
        Jeff Layton <jlayton@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        netdev <netdev@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        "linux-samsung-soc@vger.kernel.org" 
        <linux-samsung-soc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 15, 2018 at 4:23 PM, Chuck Lever <chuck.lever@oracle.com> wrote=
:
>
>
>> On Jun 15, 2018, at 10:07 AM, Krzysztof Kozlowski <krzk@kernel.org> wrot=
e:
>>
>> On Fri, Jun 15, 2018 at 2:53 PM, Sudeep Holla <sudeep.holla@arm.com> wro=
te:
>>> Hi,
>>>
>>> On Thu, Jun 7, 2018 at 12:19 PM, Krzysztof Kozlowski <krzk@kernel.org> =
wrote:
>>>> Hi,
>>>>
>>>> When booting my boards under recent linux-next, I see failures of syst=
emd:
>>>>
>>>> [FAILED] Failed to start Flush Journal to Persistent Storage.
>>>> See 'systemctl status systemd-journal-flush.service' for details.
>>>>         Starting Create Volatile Files and Directories...
>>>> [**    ] A start job is running for Create V=E2=80=A6 [  223.209289] n=
fs:
>>>> server 192.168.1.10 not responding, still trying
>>>> [  223.209377] nfs: server 192.168.1.10 not responding, still trying
>>>>
>>>> Effectively the boards fails to boot. Example is here:
>>>> https://krzk.eu/#/builders/1/builds/2157
>>>>
>>>
>>> I too encountered the same issue.
>>>
>>>> This was bisected to:
>>>> commit 37ac86c3a76c113619b7d9afe0251bbfc04cb80a
>>>> Author: Chuck Lever <chuck.lever@oracle.com>
>>>> Date:   Fri May 4 15:34:53 2018 -0400
>>>>
>>>>    SUNRPC: Initialize rpc_rqst outside of xprt->reserve_lock
>>>>
>>>>    alloc_slot is a transport-specific op, but initializing an rpc_rqst
>>>>    is common to all transports. In addition, the only part of initial-
>>>>    izing an rpc_rqst that needs serialization is getting a fresh XID.
>>>>
>>>>    Move rpc_rqst initialization to common code in preparation for
>>>>    adding a transport-specific alloc_slot to xprtrdma.
>>>>
>>>>    Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
>>>>    Signed-off-by: Anna Schumaker <Anna.Schumaker@Netapp.com>
>>>>
>>>
>>> Unfortunately, spent time to bisect independently without seeing this
>>> report and got the same culprit.
>>>
>>>>
>>>> Bisect log attached. Full configuration:
>>>> 1. exynos_defconfig
>>>> 2. ARMv7, octa-core, Exynos5422 and Exynos4412 (Odroid XU3, U3 and oth=
ers)
>>>> 3. NFSv4 client (from Raspberry Pi)
>>>>
>>>
>>> Yes the issue is seen only with NFSv4 client and with latest systemd I =
think.
>>> My Ubuntu 16.04(32bit FS) is  boots fine while 18.04 has the above issu=
e.
>>> Passing nfsv3 in kernel command line makes it work again.
>>
>> Thanks for reply!
>>
>> I test it on systemd versions 236 and 238... and it fails on both.
>> However one board passes always - it is Odroid HC1 with same core
>> configuration as described before. Probably there is some different SW
>> package on it.
>>
>>>> Let me know if you need any more information.
>>>>
>>>
>>> Also I was observing this issue with Linus master branch from
>>> the time the above patch was merged until today. The issue
>>> is no longer seen since this morning however I just enabled lockdep
>>> and got these messages.
>>
>> All recent linux-next fail. Today's Linus' tree (4c5e8fc62d6a ("Merge
>> tag 'linux-kselftest-4.18-rc1-2' of
>> git://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest"))
>> managed to get up on one board but stuck on different board with the
>> same issue.
>>
>> I am quite surprised that there is no response from the author of the
>> commit and this was just moved from next (while failing) to Linus'
>> tree... bringing the issue to mainline now.
>
> Sorry. This morning is the first time I've seen this report, which was
> not To: or Cc'd to me.

D'oh! That's mine mistake. Apparently I missed to put you on CC list.
Sorry for that.


> Since I don't have access to this kind of hardware, I will have to ask
> for your help to perform basic troubleshooting.
>
> Can we start by capturing the network traffic that occurs while you
> reproduce the problem? Use tshark or tcpdump on your NFS server, filter
> on the IP of the client, and send me (or the list) the raw pcap file.

Sure, I'll send you tcpdump without Cc-ing list.

Best regards,
Krzysztof
