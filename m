Return-Path: <SRS0=aVpA=KZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D08B1C46464
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Aug 2018 19:33:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 95F3F2242A
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Aug 2018 19:33:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 95F3F2242A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727320AbeHJWEd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Aug 2018 18:04:33 -0400
Received: from mail-qt0-f195.google.com ([209.85.216.195]:35694 "EHLO
        mail-qt0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726446AbeHJWEd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Aug 2018 18:04:33 -0400
Received: by mail-qt0-f195.google.com with SMTP id r21-v6so11517548qtm.2
        for <linux-kernel@vger.kernel.org>; Fri, 10 Aug 2018 12:33:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=UBrT2ADn23AtPtLsNVnlwbihYGbGULQ5164YVN9r6x8=;
        b=KvrajGtGc8G+dYGD5bQMoRpDZ878snTc8Z/2vi8bDasWu2zVHCCIpPOlgZjkax3lk+
         Jxnt3E3FTPOOSLmF4m4md70iF1vrIyiarNrx7Yb7wBdqdWin8D1yQMzMEbTRa1k8MUPE
         VUmW+A9ynwSY6z2PSrehDXolMul+rh48QgAFFCXq8Oskuj8zOnP0jdBd6HnK8El+Q5QM
         HBzdnbF0OWRF6R8jteivV3Bg1saJXmAobVpBx4qJ7fXANIF02qMvyAdqR/AKgr4t1zu/
         hfsrMwOjq1EfoMBQ3jBT+T4qnvlI5uFbJWS//v52k3u+gwQxM4pBU9WSRg08f5Bd/I++
         x0FA==
X-Gm-Message-State: AOUpUlG3ptY5Y61LTKbnkivseBQVH0eXA7SQPptFnqMB143q21eTMzVe
        RIwHr/YK93sP+glqj2UUyUzCGgDRIfg7MOoUgIeJrw==
X-Google-Smtp-Source: AA+uWPz+wQza/xiaWeza76QsssaXhyuO5NUaZsspX5Z0oJ2EEyl6kEN5NWFmgBGpkdgXc4BtDzUCTJVCfaErUJUNAGo=
X-Received: by 2002:ac8:1bb8:: with SMTP id z53-v6mr8173135qtj.278.1533929599784;
 Fri, 10 Aug 2018 12:33:19 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a0c:cc04:0:0:0:0:0 with HTTP; Fri, 10 Aug 2018 12:33:19
 -0700 (PDT)
In-Reply-To: <CACVXFVMEgKEUQE8ALCjEvhxMtEzFYyP8QUM2ds8-Uw=x7USFAg@mail.gmail.com>
References: <CAK=WzwePk3iREsb3mz_+RuHV_f2WhcQ9AECnMCWGW2wW=4amew@mail.gmail.com>
 <CACVXFVMEgKEUQE8ALCjEvhxMtEzFYyP8QUM2ds8-Uw=x7USFAg@mail.gmail.com>
From:   Andrew Jeddeloh <andrew.jeddeloh@redhat.com>
Date:   Fri, 10 Aug 2018 12:33:19 -0700
Message-ID: <CAK=Wzwf3+KX=RowWYMwJCw7S5-Vj+pZ5-rtxEeMAmB=X1hiNQw@mail.gmail.com>
Subject: Re: [BUG] Loopback devices with 4k logical block size are not
 automatically scanned for GPT partitions
To:     Ming Lei <tom.leiming@gmail.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-block <linux-block@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I tried with qemu virtio-blk-pci (couldn't find a qemu option for
logical or physical block size for virtio-scsi-pci) and it found the
partition when booting. I see

virtio_blk virtio1: [vdb] 262144 4096-byte logical blocks (1.07 GB/1.00 GiB)

quickly followed by

 vdb: vdb1

on dmesg on bootup. I haven't tried hotplugging it yet. I don't know
if that would matter.

 - Andrew Jeddeloh

On Thu, Aug 9, 2018 at 1:10 AM, Ming Lei <tom.leiming@gmail.com> wrote:
> On Thu, Aug 9, 2018 at 7:30 AM, Andrew Jeddeloh
> <andrew.jeddeloh@redhat.com> wrote:
>> I think I found a bug with partition scanning/loopback devices with 4k
>> logical sectors. It affects 4.14.x and 4.17.x kernels (and presumably
>> others). I've also filed the bug on the kernel bugzilla:
>>
>> https://bugzilla.kernel.org/show_bug.cgi?id=200749
>>
>> Copied from the bugzilla report:
>>
>> Loop devices with the logical sector size set to 4096 do not
>> autodetect partitions when attached. It may be the case for devices
>> with 4k logical sectors in general, but I do not have hardware to test
>> that. I have not tested with non-GPT disks.
>
> You may setup 4k sector-size with scsi_debug or qemu virtio-scsi,
> then try to reproduce on these devices.
>
> Cc block list.
>
>
> Thanks,
> Ming Lei
