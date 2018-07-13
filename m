Return-Path: <SRS0=Zbfl=J5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD8E7ECDFB1
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 06:36:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5C9B32124D
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 06:36:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eveoQNQL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5C9B32124D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727409AbeGMGtq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Jul 2018 02:49:46 -0400
Received: from mail-lf0-f51.google.com ([209.85.215.51]:39027 "EHLO
        mail-lf0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726035AbeGMGtp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jul 2018 02:49:45 -0400
Received: by mail-lf0-f51.google.com with SMTP id a134-v6so26244370lfe.6;
        Thu, 12 Jul 2018 23:36:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=ErpeeWZ20KxDIqNI8CPe2RaM2figFGuM4ZneflYRZgY=;
        b=eveoQNQLmjrDiU0wz5AtHrUCY781mmCzAateHV6LwfZCIB6Ca+Pdns4qR/4B6ScPsl
         Jta/3MMm4yGI2W8MoxvZOw0+/a8inGEYMPPIqb2pMGWqMnWT9WD+sKvQGsFpGcxUuSL7
         kEjEgR+aK3yYOsT8y39iJcAuWGFRO8Axi1u3ahABCUw1W36fWTpp9Gs2WLDlAlmlIvoU
         lyAOY8iOl0O2VKnvjYk6ObT71eZda2OulWmR50KuBOsfmWIJmR2fzG0UlB6kUwmS7q4Q
         hS8l7xUMXs7KylRwyYEu7NhMJzV++FgT0U/OhU5AzRxxEHujyPznq3xNFEAUQt2BrO0e
         jDfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=ErpeeWZ20KxDIqNI8CPe2RaM2figFGuM4ZneflYRZgY=;
        b=aywWf6CEP1IVM1LXDv2SX2E20U5lUkF3HZcL4Cx799Th9MJWcQRaapQIPvxJwtZXao
         CQW7Y+vNCJA0ornz7J+pM3Z0XnIJ9snydEzjLxdAPFS/u2bOw9y+/PhQCuYLk11lmggp
         Q1wEDffjEwpssAVwyPx6zaRXNRTIBYj8aPq+u5GA0q1UxfBfSsGOqYaEm2Mw0E/7ZkpE
         yIrZ6KnSFWxuiiocD69O/oFikyZ768gO12fdcpIHzp3GzHiIAGw4k4XvrYuj11VfIiI9
         35HX+xGVkTTrceXyyUuwlQ90fNiaqrTRNcrRVjrGKp3btzoVoEieOCA0fYeyxRJCIVaR
         4Znw==
X-Gm-Message-State: AOUpUlHIWblaXeQfJpoB6I7cIKjiF2If8jgkas1CQ4v/Rj4wZ7MHkwDv
        4tf4exJ4IDyunnN+Zs0wMIhwanTJ
X-Google-Smtp-Source: AAOMgpfuGXa0aPuoxJ6jJ2Trj8qBsICK5rrzpShT9JY3nMVzRbyUJSChBfMWWkcuaMj5/JvvqPGgPQ==
X-Received: by 2002:a19:e307:: with SMTP id a7-v6mr880064lfh.125.1531463793654;
        Thu, 12 Jul 2018 23:36:33 -0700 (PDT)
Received: from xi.terra (c-8bb2e655.07-184-6d6c6d4.bbcust.telenor.se. [85.230.178.139])
        by smtp.gmail.com with ESMTPSA id l3-v6sm5166985lfi.36.2018.07.12.23.36.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 12 Jul 2018 23:36:32 -0700 (PDT)
Received: from johan by xi.terra with local (Exim 4.91)
        (envelope-from <johan@kernel.org>)
        id 1fdrgq-0005kK-HH; Fri, 13 Jul 2018 08:36:29 +0200
Date:   Fri, 13 Jul 2018 08:36:28 +0200
From:   Johan Hovold <johan@kernel.org>
To:     MovieSong <MovieSong@aten-itlab.cn>
Cc:     johan <johan@kernel.org>, gregkh <gregkh@linuxfoundation.org>,
        linux-usb <linux-usb@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        YorkDai <YorkDai@aten-itlab.cn>, BillLi <BillLi@aten-itlab.cn>
Subject: Re: 0001-This-add-a-new-device-for-ATEN
Message-ID: <20180713063628.GE10204@localhost>
References: <201807130229.w6D2TTB2089009@mse.aten.com.tw>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <201807130229.w6D2TTB2089009@mse.aten.com.tw>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 13, 2018 at 10:26:59AM +0800, MovieSong wrote:
> Email:MovieSong@aten-itlab.cnThis email/file contains information that is for sole use of the intended recipient and may be confidential or privileged. ANY UNAUTHORIZED REVIEW, COPYING, DISCLOSURE, USE OR DISTRIBUTION IS STRICTLY PROHIBITED. Please notify the sender and destroy the original email/file if your receipt of this email is in error. 本电子邮件或档案之内容为机密信息，仅供宏正公司授权之人使用。任何非经宏正公司授权之人所为之阅览、复印、披露、使用或散布本电子邮件或档案之行为将被严格禁止。如您未经宏正公司授权而接收到本电子邮件或档案，请立即通知发信人或档案提出人并立即删除或销毁该电子邮件或档案。 

Not much we can do with this as long as you include a footer like the
above one. Can you ask your admins to remove it, or send from a
different account?

Also please send your patches inline rather than as attachments.

Thanks,
Johan
