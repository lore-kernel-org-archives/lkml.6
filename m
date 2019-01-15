Return-Path: <SRS0=RZO6=PX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3E6CC43444
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 03:14:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 930F220645
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 03:14:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=me.com header.i=@me.com header.b="cjjTt5e4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727799AbfAODOB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Jan 2019 22:14:01 -0500
Received: from mr85p00im-ztdg06011101.me.com ([17.58.23.185]:32588 "EHLO
        mr85p00im-ztdg06011101.me.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727221AbfAODOB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jan 2019 22:14:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=me.com; s=04042017;
        t=1547521656; bh=tiUVwvuyn5ch7Fix+opu1tSqHzYS2WEovmqIj4t4f10=;
        h=Content-Type:Mime-Version:Subject:From:Date:Message-Id:To;
        b=cjjTt5e4RBBB8O7Al5OAAUUKgBCww43vF529xM+VMpbgytJ8qEl0mBzyQ9IGK9H7M
         0rYERSmPcH0QXNVfBKzww57ZhmCk1aNJBNOG+9XbJJnnAEeus07O0V9pNTVjsCrhnX
         4WBANsylNDwuhB2ACEO2si1caBRn2HChiusC8mFFPcxh7vpLEBM8S6oNJkDXw1kQBc
         G7nG3adGx8EDdpe+3ZMTWWrGrELrpLnjEP/cgz20vehJuclxvmihPCY4EPxQnAn9d0
         MXbQI7xWkbb7kDIYgfUM6dxveRIfhVa3j5EunxXGEKagEKI4E1c14ykSTraeEDo7j8
         E+5j8A0DyoZbg==
Received: from [192.168.2.195] (c-73-241-76-75.hsd1.ca.comcast.net [73.241.76.75])
        by mr85p00im-ztdg06011101.me.com (Postfix) with ESMTPSA id 373F74A0097;
        Tue, 15 Jan 2019 03:07:36 +0000 (UTC)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 11.5 \(3445.9.1\))
Subject: Re: udf: Prevent write-unsupported filesystem to be remounted
 read-write
From:   Michael Sabolish <sabolish@me.com>
In-Reply-To: <20190114123042.GH13316@quack2.suse.cz>
Date:   Mon, 14 Jan 2019 19:07:35 -0800
Cc:     =?utf-8?Q?Pali_Roh=C3=A1r?= <pali.rohar@gmail.com>,
        Kevin Weidemann <kwe-lnx@postn.eu>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <E11914DA-D254-4198-A152-F9D6E61514BE@me.com>
References: <124cc6ea-ca79-20f2-651e-c2f909729ac0@gmx.de>
 <8cf39b7c-505b-91e6-849d-e66ba980042f@postn.eu>
 <20190114103011.GD13316@quack2.suse.cz>
 <20190114120023.wkftfz6pwatehpfe@pali>
 <20190114123042.GH13316@quack2.suse.cz>
To:     Jan Kara <jack@suse.cz>
X-Mailer: Apple Mail (2.3445.9.1)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-01-15_01:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011 mlxscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1901150024
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I can try and make a pull-request for udftune, and I can just copy the =
API for tune2fs.  It would work something like:

udftune -O read-only device            (to set read-only access type)

or:

udftune -O ^read-only device          (to clear read-only access type =
(aka set rw))


> On Jan 14, 2019, at 4:30 AM, Jan Kara <jack@suse.cz> wrote:
>=20
> On Mon 14-01-19 13:00:23, Pali Roh=C3=A1r wrote:
>> On Monday 14 January 2019 11:30:11 Jan Kara wrote:
>>>> As for the case of remounting as rw if the UDF is ro but the device =
is
>>>> rw, I am not sure what the best idea is to deal with this.  If this =
new
>>>> behavior doesn't count as a regression, is there any way to end up =
with a
>>>> UDF filesystem as specced by the command above (-m dvd -b 512, so =
with it
>>>> being read-only), but still allow for mounting it as rw if the =
device
>>>> supports it? Does udftools offer a way to manipulate the UDF =
partition
>>>> descriptor flag in a pre-existing filesystem after it had already =
been
>>>> created that I am missing?
>>>=20
>>> So I would really prefer to keep the behavior of disallowing =
remounting
>>> read-only partition read write. After all ECMA-167 standard is =
pretty clear
>>> on this saying that for read-only partitions no sectors can be =
recorded. I
>>> understand it is inconvenient if you try to create e.g. a DVD image. =
So you
>>> want partition to be read-only in the end but initially you need it =
to be
>>> writeable so that you can fill-in the contents.
>>>=20
>>> Generally I think a clean solution for this is to provide a way in =
udftools
>>> to switch partition read-only / read-write. Also this is how similar =
things
>>> are achieved for other filesystems. Pali, is there a way to switch
>>> accessType of a partition on existing media with udftools? If not, =
can you
>>> look into implementing that please? It should be rather =
straightforward,
>>> the biggest question really is which tool should do this...
>>=20
>> You are not the first who asked for such functionality in udftools.
>> Michael (CCed) already experimented with such thing and "hacked"
>> udflabel to switch access type from overwritable to readonly.
>>=20
>> I'm not against adding a new tool into udftools project which can
>> manipulate UDF access type. Question is design / API of such tool.
>>=20
>> Currently udftools has udfinfo tool which prints lot of information
>> about UDF filesystem (including access type). But the only tool which
>> modifies UDF filesystem in udftools is udflabel. And udflabel is not
>> really the proper place for changing access type.
>>=20
>> So some new tool for modifying UDF filesystem would be better. Which
>> other settings of UDF filesystem could be useful to be modifiable? =
I'm
>> thinking about "udftune" where new features for modification could be
>> implemented later too.
>=20
> Yes, that sounds good to me and is in line with what tools for other
> filesystems have.
>=20
> 								Honza
> --=20
> Jan Kara <jack@suse.com>
> SUSE Labs, CR

