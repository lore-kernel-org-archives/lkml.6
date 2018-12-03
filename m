Return-Path: <SRS0=Grn6=OM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4AEFC65BAE
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 09:15:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B634921479
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 09:15:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B634921479
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xs4all.nl
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726034AbeLCJPb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Dec 2018 04:15:31 -0500
Received: from lb1-smtp-cloud7.xs4all.net ([194.109.24.24]:51982 "EHLO
        lb1-smtp-cloud7.xs4all.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725874AbeLCJPb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Dec 2018 04:15:31 -0500
Received: from [192.168.2.10] ([212.251.195.8])
        by smtp-cloud7.xs4all.net with ESMTPA
        id TkJugpPYbfGaRTkJxghtet; Mon, 03 Dec 2018 10:15:19 +0100
Subject: Re: [PATCH v4] media: vivid: Improve timestamping
To:     Arnd Bergmann <arnd@arndb.de>, gfmandaji@gmail.com
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Linux Media Mailing List <linux-media@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        lkcamp@lists.libreplanetbr.org
References: <20181202134538.GA18886@gfm-note>
 <CAK8P3a2of9sZ5BGCKshCjFkpt8q6s-KD-9XC4SGYP2Ppj7fjEw@mail.gmail.com>
From:   Hans Verkuil <hverkuil@xs4all.nl>
Message-ID: <c3d75256-bfdc-6f36-1e6e-ad4e5cd9b855@xs4all.nl>
Date:   Mon, 3 Dec 2018 10:15:14 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <CAK8P3a2of9sZ5BGCKshCjFkpt8q6s-KD-9XC4SGYP2Ppj7fjEw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfGXTXu6KYqZC9C9nihSokyyPEsCttLnsNEtd/vtV6PeCX06GwTtDk4bEAlExgTEgy3et89k869cplOpquKScnDfO/bxqNsI9Dyj5xFaeECn53jgT6zYg
 9GVaBGCkI6lKu3x7Zk2q2VfLYco5HIZRqz4cmQMmKN62WpenWYZ19a3RP1VBRMz/0M/XZ/OT0BFrivCLnDe0Dspr8xZMNEi5zqhYk7aDTyv8Ud9RY9KkdwCR
 BWrF7xoR43ZwaIf8+N8aOnoA5AEpDqFpJGMFzO6IutDJ2IMy9YxxyhUid0kKmxd0lR+0fm+/f8FZtMADsFJEUDhZe/3Q2xJ6KIwVB3I/YVeV8J91+wr+Rxp1
 NG1T1yhr
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/02/2018 09:43 PM, Arnd Bergmann wrote:
> On Sun, Dec 2, 2018 at 2:47 PM Gabriel Francisco Mandaji
> <gfmandaji@gmail.com> wrote:
> 
>> @@ -667,10 +653,28 @@ static void vivid_overlay(struct vivid_dev *dev, struct vivid_buffer *buf)
>>         }
>>  }
>>
>> +static void vivid_cap_update_frame_period(struct vivid_dev *dev)
>> +{
>> +       u64 f_period;
>> +
>> +       f_period = (u64)dev->timeperframe_vid_cap.numerator * 1000000000;
>> +       do_div(f_period, dev->timeperframe_vid_cap.denominator);
>> +       if (dev->field_cap == V4L2_FIELD_ALTERNATE)
>> +               do_div(f_period, 2);
>> +       /*
>> +        * If "End of Frame", then offset the exposure time by 0.9
>> +        * of the frame period.
>> +        */
>> +       dev->cap_frame_eof_offset = f_period * 9;
>> +       do_div(dev->cap_frame_eof_offset, 10);
>> +       dev->cap_frame_period = f_period;
>> +}
> 
> Doing two or three do_div() operations is going to make this rather
> expensive on 32-bit architectures, and it looks like this happens for
> each frame?
> 
> Since each one is a multiplication followed by a division, could this
> be changed to using a different factor followed by a bit shift?

The division by 2 can obviously be replaced by a shift, and the
'End of Frame' calculation can be simplified as well by multiplying by
7 and dividing by 8 (again a simple shift): this equals 0.875 which is
close enough to 0.9 (so update the comment as well).

It's all a bit overkill since this function isn't called very often,
but these are easy changes to make.

Regards,

	Hans
