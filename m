Return-Path: <SRS0=5j8r=K6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6C59C46460
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Aug 2018 07:30:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8AFC7215F2
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Aug 2018 07:30:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk header.b="OcyrKJpr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8AFC7215F2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rasmusvillemoes.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728925AbeHOKVp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Aug 2018 06:21:45 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:34762 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728529AbeHOKVo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Aug 2018 06:21:44 -0400
Received: by mail-lf1-f66.google.com with SMTP id n96-v6so266982lfi.1
        for <linux-kernel@vger.kernel.org>; Wed, 15 Aug 2018 00:30:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=TF+6Lke9Rw3quNcHPDBxSsvIZvnveqW+hjTB7OiwTOs=;
        b=OcyrKJprte6KcxhzWjKvMoQhLR44KfxY4zi3oDNUW5sJQcqh4L2Hf32y0nSxlEjN1U
         lI9oOSJgI97NR43fmOd3871zJDGbK0XPq/H3KyX2x3CTAIf0Zt8dLRPciniliT3t7yuj
         stlrHD/Nd4Pyz5we6R2ooY8isSRMLuf5tuK5c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=TF+6Lke9Rw3quNcHPDBxSsvIZvnveqW+hjTB7OiwTOs=;
        b=CwbZXfna21qYLbTtsz2g88khL15zp4INc52r1k+jovznciYYnLySXvnJhBP4+yaHec
         cTgRdNC4HMzrb2ZMarAbDzJOvXjWyXBCYDxdKpisrUz25/sNi5jZW7z4b+iMOegl6Q0I
         t/r+VwGt4Qi6EjZrn+kWYihn/yt0V091nW4OuA9nvBTu8m5hNnmkkLs4PREad+Qtf94x
         g/NIGe36zpb7Z5YP8un9EYcjXRxHM8yNT/ET17HcbzfLk3ymTo6xjly5cX8hNsAPAeOo
         rMdsOI3DbDTf/Y5qX/pCUGUvEdhq03xYhalRRPoKgtsgXqESQFAXKXyu7MyayfyQ83gs
         VG2Q==
X-Gm-Message-State: AOUpUlH3Qrucq8gulnP/hLRb8flhWLF1CfeThMaGhpkCGXxc6umwf4g2
        7xJWKlM7I6yza+2UBglRMfFAhOIDgPT7MQ==
X-Google-Smtp-Source: AA+uWPxBFTJjZLW4/Tk+JqeYAuH14q3P6g+Srby2MH4OgtLV3kOzZ35FqljsczXFxFojplR//tdVdg==
X-Received: by 2002:a19:a053:: with SMTP id j80-v6mr813312lfe.115.1534318240964;
        Wed, 15 Aug 2018 00:30:40 -0700 (PDT)
Received: from [172.16.11.40] ([81.216.59.226])
        by smtp.gmail.com with ESMTPSA id m12-v6sm3838929ljh.24.2018.08.15.00.30.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 15 Aug 2018 00:30:40 -0700 (PDT)
Subject: Re: [PATCH] perf: disable parallelism for 'make clean'
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-kernel@vger.kernel.org
References: <20180705131527.19749-1-linux@rasmusvillemoes.dk>
 <20180705134955.GB3686@krava>
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
Message-ID: <25cef02d-e991-859b-3cc1-8fc81b8567fb@rasmusvillemoes.dk>
Date:   Wed, 15 Aug 2018 09:30:39 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180705134955.GB3686@krava>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-07-05 15:49, Jiri Olsa wrote:
> On Thu, Jul 05, 2018 at 03:15:27PM +0200, Rasmus Villemoes wrote:

>> this only happens in combination with a O=... parameter. In any case, we
>> don't lose much by explicitly disabling the parallelism for the clean
>> target, and it makes automated builds much more reliable.
>>
>> Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
> 
> Acked-by: Jiri Olsa <jolsa@kernel.org>

Was this picked up by anyone? I'm not seeing it in -next?

Rasmus
