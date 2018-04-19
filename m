Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753388AbeDSTIv (ORCPT <rfc822;w@1wt.eu>);
        Thu, 19 Apr 2018 15:08:51 -0400
Received: from mail-wr0-f175.google.com ([209.85.128.175]:41676 "EHLO
        mail-wr0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753117AbeDSTIu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Apr 2018 15:08:50 -0400
X-Google-Smtp-Source: AB8JxZqx23XMWWj/vXUh3cKKK3+fvafT010hE/7iWHy7KRvHuj+XL7z+i4SNVXLBkWQhospO5U1J0A==
Date: Thu, 19 Apr 2018 22:08:46 +0300
From: Alexey Dobriyan <adobriyan@gmail.com>
To: longman@redhat.com
Cc: linux-kernel@vger.kernel.org, rdunlap@infradead.org
Subject: Re: [PATCH] proc/stat: Separate out individual irq counts into
 /proc/stat_irqs
Message-ID: <20180419190846.GE2066@avx2>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Therefore, application performance can be impacted if the application
> reads /proc/stat rather frequently.

[nods]
Text interfaces can be designed in a very stupid way.

> For example, reading /proc/stat in a certain 2-socket Skylake server
> took about 4.6ms because it had over 5k irqs.

Is this top(1)? What is this application doing?
If it needs percpu usage stats, then maybe /proc/stat should be
converted away from single_open() so that core seq_file code doesn't
generate everything at once.

> -
> -	/* sum again ? it could be updated? */
> -	for_each_irq_nr(j)
> -		seq_put_decimal_ull(p, " ", kstat_irqs_usr(j));
> -

This is direct userspace breakage.

Proper fix is to start strategic switch away from /proc.
It is a fun toy but its time has come.
