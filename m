Return-Path: <SRS0=v2je=OV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64338C04EB8
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 07:03:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 298DE20851
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 07:03:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=xenosoft.de header.i=@xenosoft.de header.b="AuKsvPyz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 298DE20851
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xenosoft.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726614AbeLLHDw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Dec 2018 02:03:52 -0500
Received: from mo4-p01-ob.smtp.rzone.de ([81.169.146.164]:36667 "EHLO
        mo4-p01-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726251AbeLLHDu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Dec 2018 02:03:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1544598228;
        s=strato-dkim-0002; d=xenosoft.de;
        h=To:References:Message-Id:Cc:Date:In-Reply-To:From:Subject:
        X-RZG-CLASS-ID:X-RZG-AUTH:From:Subject:Sender;
        bh=PcaQMij3IhasAIn1L/QX0knVHDE+RBFUQFsFKkzwR9Q=;
        b=AuKsvPyzx0E9tzHRJXvnbQAzbIkNDCwniALTSjf64AYUGucEl0IF21gJZuwu5QV8DI
        aTtIx4h2nw3iIVy3SQkzcihUhoeFoVYEVZqgU5n5Pd9u8HlEhpGAD5U04Mj/Xn9EGzWR
        PHfY6atX3wuEuKJHuiDmDEUXAQ4yrUroWilOsndM7PaagqYaZ7OhTHgCgosrEiZpIU5y
        P6FjTg6Bbb4d7FlpBj14efXgQDRRt0zSOX7WT0huUM9kMlccBX2qR43stD8TdDv8WgNz
        WXVXYTtx6mP1GjuVu5cFEyJ9vdhsJ8oDbvOy4jXeYaKAKOQaS7zP7UcqQDcH4E4aCiAu
        2AMQ==
X-RZG-AUTH: ":L2QefEenb+UdBJSdRCXu93KJ1bmSGnhMdmOod1DhGN0rBVhd9dFr44+gKiZpmhkMNrXaTDU="
X-RZG-CLASS-ID: mo00
Received: from [192.168.178.26]
        by smtp.strato.de (RZmta 44.7 DYNA|AUTH)
        with ESMTPSA id j074b8uBC73Q9yu
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (curve secp521r1 with 521 ECDH bits, eq. 15360 bits RSA))
        (Client did not present a certificate);
        Wed, 12 Dec 2018 08:03:26 +0100 (CET)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (1.0)
Subject: Re: use generic DMA mapping code in powerpc V4
From:   Christian Zigotzky <chzigotzky@xenosoft.de>
X-Mailer: iPhone Mail (15G77)
In-Reply-To: <d447ac4e18bddd030aa2f56a0547c0132b3f8dcd.camel@kernel.crashing.org>
Date:   Wed, 12 Dec 2018 08:03:26 +0100
Cc:     Christoph Hellwig <hch@lst.de>, linux-arch@vger.kernel.org,
        Darren Stevens <darren@stevens-zone.net>,
        linux-kernel@vger.kernel.org, Julian Margetson <runaway@candw.ms>,
        linux-mm@kvack.org, iommu@lists.linux-foundation.org,
        Paul Mackerras <paulus@samba.org>,
        Olof Johansson <olof@lixom.net>, linuxppc-dev@lists.ozlabs.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <D81A7627-474E-448B-B64C-B51A636730CC@xenosoft.de>
References: <20181129170351.GC27951@lst.de> <d0e04a85-f17d-414e-6fea-971414417430@xenosoft.de> <20181130105346.GB26765@lst.de> <8694431d-c669-b7b9-99fa-e99db5d45a7d@xenosoft.de> <20181130131056.GA5211@lst.de> <25999587-2d91-a63c-ed38-c3fb0075d9f1@xenosoft.de> <c5202d29-863d-1377-0e2d-762203b317e2@xenosoft.de> <58c61afb-290f-6196-c72c-ac7b61b84718@xenosoft.de> <20181204142426.GA2743@lst.de> <ef56d279-f75d-008e-71ba-7068c1b37c48@xenosoft.de> <20181205140550.GA27549@lst.de> <1948cf84-49ab-543c-472c-d18e27751903@xenosoft.de> <5a2ea855-b4b0-e48a-5c3e-c859a8451ca2@xenosoft.de> <7B6DDB28-8BF6-4589-84ED-F1D4D13BFED6@xenosoft.de> <8a2c4581-0c85-8065-f37e-984755eb31ab@xenosoft.de> <424bb228-c9e5-6593-1ab7-5950d9b2bd4e@xenosoft.de> <c86d76b4-b199-557e-bc64-4235729c1e72@xenosoft.de> <1ecb7692-f3fb-a246-91f9-2db1b9496305@xenosoft.de> <6c997c03-e072-97a9-8ae0-38a4363df919@xenosoft.de> <4cfb3f26-74e1-db01-b014-759f188bb5a6@xenosoft.de> <82879d3f-83de-6438-c1d6-49c571dcb671@xenosoft.de> <d447ac4e18b
 ddd030aa2f56a0547c0132b3f8dcd.camel@kernel.crashing.org>
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On 12. Dec 2018, at 01:47, Benjamin Herrenschmidt <benh@kernel.crashing.or=
g> wrote:
>=20
>> On Tue, 2018-12-11 at 19:17 +0100, Christian Zigotzky wrote:
>> X5000 (P5020 board): U-Boot loads the kernel and the dtb file. Then the=20=

>> kernel starts but it doesn't find any hard disks (partitions). That=20
>> means this is also the bad commit for the P5020 board.
>=20
> What are the disks hanging off ? A PCIe device of some sort ?
>=20
> Can you send good & bad dmesg logs ?
>=20
> Ben.
>=20
>=20
Unfortunately not. It doesn=E2=80=99t detect any hard disk. That means the k=
ernel ring buffer won=E2=80=99t save to log files. I don=E2=80=99t have a se=
rial null modem cable for seeing all output. We use SATA disks. I will inves=
tigate more in this problem with rollback the files in the bad commit.

=E2=80=94 Christian



