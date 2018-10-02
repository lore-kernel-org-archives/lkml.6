Return-Path: <SRS0=iNRz=MO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 052E4C64EBC
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 23:44:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 68334206B2
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 23:44:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cukUdAHf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 68334206B2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lwfinger.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726521AbeJCGab (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Oct 2018 02:30:31 -0400
Received: from mail-oi1-f173.google.com ([209.85.167.173]:36742 "EHLO
        mail-oi1-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725767AbeJCGab (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Oct 2018 02:30:31 -0400
Received: by mail-oi1-f173.google.com with SMTP id p125-v6so3037359oic.3
        for <linux-kernel@vger.kernel.org>; Tue, 02 Oct 2018 16:44:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:to:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=pAKI+vQY+uxqUZMl0o3kBgnfukf4svc7ZRjW/w2YqlY=;
        b=cukUdAHfiqAZk60ZDdNuJf5bt3OqUaDs2iq2Yv6/poPS9LD7hzWn4ZvaUlGv5/VqL8
         GuOrivjldGejpRMirq/4Oie+sq6PF0XVp9V5Ux311mujDAlfupJ4iv55xhdPSQQGBr/Q
         rTW4wvRusSXC51RP9dmPlKc9exgLUtcikrQWB63JIpJC6JsdhoNRaKuTTXzXGddF6Jmg
         6jVw7AHOZfh+QvaJ8vLk8UpX3tqeY8miAcoAekaH1aDtNHSATV2/FNyNMpGdDkVeKyyh
         so7Co45jhR0GIv7N9tNWFUU1GtYy4JxFSghSl+NA3kH/3H4/LIYd7acLbwGwYKifEBNk
         8bmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:to:from:subject:message-id:date
         :user-agent:mime-version:content-language:content-transfer-encoding;
        bh=pAKI+vQY+uxqUZMl0o3kBgnfukf4svc7ZRjW/w2YqlY=;
        b=MQ2owMKE5SddJWowwOi8SszQRuotsSxYhPPIB/PcgTeJfX2uRPX0vievOuA8kz46Oc
         x0JsQ01gR76DnFXGtpgm6syfN27WuNz+pfo4ZEic8Wywunyq6CTNBJMI8t5PjTZxC7Xp
         9A+g5L+4qNmZh6CW6wd3IH4Nc8MXVzJ8Z2HZDtTL5CP6niX+guoOC9IVzXmdeKNDrUv/
         W9ZXNpsV2KMErDU7N5INesEaDRXtwByoIZWzc+52Awod4RyQsiWtC0D5ouOxCrOBgIQh
         YpLP4FcKxrYp6sUVhbnzDtZiMusmtwfgcywFhgYcvitxa1RloayI5FEspPt531b+i0g9
         Zxbg==
X-Gm-Message-State: ABuFfojqHMea+bA8oBWDX5PrQPhPwGSHeogLBt58XFyG7rt2ZQy8i3n2
        S6zetX74miuvIVCIR+bCXHEJHqZZ
X-Google-Smtp-Source: ACcGV608d1wgY5N1pT/9sL5YnG4GOxJO/oX5fGxFp6sIejBPNMxjy30rcOgvXcEqBTGKaOwGHjV7rg==
X-Received: by 2002:aca:c351:: with SMTP id t78-v6mr4149468oif.338.1538523880867;
        Tue, 02 Oct 2018 16:44:40 -0700 (PDT)
Received: from [192.168.1.107] (cpe-24-31-245-230.kc.res.rr.com. [24.31.245.230])
        by smtp.gmail.com with ESMTPSA id 143-v6sm3901212oii.16.2018.10.02.16.44.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 02 Oct 2018 16:44:40 -0700 (PDT)
To:     LKML <linux-kernel@vger.kernel.org>,
        Christopher Li <sparse@chrisli.org>
From:   Larry Finger <Larry.Finger@lwfinger.net>
Subject: Sparse warnings from calls to max3() and max
Message-ID: <3afaa0ad-33a1-33d1-f306-8e0e467936dd@lwfinger.net>
Date:   Tue, 2 Oct 2018 18:44:39 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Sparse has suddenly started issuing as many as 11 warnings of "expression using 
sizeof(void)" for each call to max3(). There are similar warnings for calls to 
max(), thus I think this is the origin of the problem. My sparse version is 
20180324-1.3-x86_64 installed in openSUSE Tumbleweed. My kernel is 4.19.0-rc6.

Thanks,

Larry
