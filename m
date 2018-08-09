Return-Path: <SRS0=+sa6=KY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CAAAC46460
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 11:24:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AF1B32157F
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 11:24:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AF1B32157F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=metafoo.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730860AbeHINs3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Aug 2018 09:48:29 -0400
Received: from www381.your-server.de ([78.46.137.84]:54682 "EHLO
        www381.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727786AbeHINs3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Aug 2018 09:48:29 -0400
Received: from [78.46.172.2] (helo=sslproxy05.your-server.de)
        by www381.your-server.de with esmtpsa (TLSv1.2:DHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89_1)
        (envelope-from <lars@metafoo.de>)
        id 1fnj2t-0003tt-AG; Thu, 09 Aug 2018 13:23:59 +0200
Received: from [2003:93:4e47:0:8200:bff:fe9b:6612]
        by sslproxy05.your-server.de with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89)
        (envelope-from <lars@metafoo.de>)
        id 1fnj2t-0005A5-3i; Thu, 09 Aug 2018 13:23:59 +0200
Subject: Re: [alsa-devel] [PATCH] ASoC: adav80x: mark expected switch
 fall-through
To:     Mark Brown <broonie@kernel.org>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc:     alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel@vger.kernel.org, Takashi Iwai <tiwai@suse.com>
References: <20180808191933.GA27767@embeddedor.com>
 <20180809093002.GB6132@sirena.org.uk>
From:   Lars-Peter Clausen <lars@metafoo.de>
Message-ID: <a68c854c-013a-8cb2-49de-5bb109b27fc3@metafoo.de>
Date:   Thu, 9 Aug 2018 13:23:58 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180809093002.GB6132@sirena.org.uk>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: lars@metafoo.de
X-Virus-Scanned: Clear (ClamAV 0.100.1/24826/Thu Aug  9 10:45:05 2018)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/09/2018 11:30 AM, Mark Brown wrote:
> On Wed, Aug 08, 2018 at 02:19:33PM -0500, Gustavo A. R. Silva wrote:
> 
>> @@ -648,6 +648,7 @@ static int adav80x_set_pll(struct snd_soc_component *component, int pll_id,
>>  			pll_ctrl1 |= ADAV80X_PLL_CTRL1_PLLDIV;
>>  			break;
>>  		}
>> +		/* fall through */
>>  	default:
>>  		return -EINVAL;
>>  	}
> 
> Are you *positive* this is a deliberate fall through?

It is. But it might make sense to re-order the code to look like

    case 54000000:
        if (source != ADAV80X_PLL_SRC_XIN)
            return -EINVAL;

        pll_ctrl1 |= ADAV80X_PLL_CTRL1_PLLDIV;
        break;

It is just as many lines added when adding the /* fall through */, but it
makes it more obvious what is going on.

Either way:

Acked-by: Lars-Peter Clausen <lars@metafoo.de>
