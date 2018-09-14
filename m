Return-Path: <SRS0=Jh2l=L4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D0ECECDFD0
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 14:08:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C91B820671
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 14:08:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZZFDCEAt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C91B820671
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728211AbeINTWz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Sep 2018 15:22:55 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:35591 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726925AbeINTWz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Sep 2018 15:22:55 -0400
Received: by mail-lf1-f68.google.com with SMTP id q13-v6so8014617lfc.2
        for <linux-kernel@vger.kernel.org>; Fri, 14 Sep 2018 07:08:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=enSzX/26Llro1MOWOfuQdbjXUtvOckNAPL3iccnpiKg=;
        b=ZZFDCEAt1JGYHKoZMar5IRu8rOqCComLFNGgqSLjm/CtZHG5zuIX2+AU+o/MQDvmbK
         HvS3vk5iczyTl/zDu7O/i7qoIbcNP5wef5Wr46DjQMKEgpuKz41NyeDuIikbeXMMnT5I
         hgpnPRAH928Y8y9+ghWAzXr9sXunaetxQPTRztYll1jdq4gTA7Eo+r9Gu2hH8awk3qMp
         XfQrPyza+3bik5LnDYne49NpsejXt/0IuH73OhrG4OqM+VtYBL16mEplC7EOWtwdKLib
         HapIV/XnrKy4RjBaZWTum7R+/IYR5tisFDXlZ6eKHyK4smf1KENewDNTdqFUqCEEK+db
         G5TA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=enSzX/26Llro1MOWOfuQdbjXUtvOckNAPL3iccnpiKg=;
        b=j20E5PyYjbjMrRsowjVvD0aRPxCDSGsaotwEJZQDQJVdvJdEahLhOJ7fyHEMMhF85c
         K023kqxvtj3hM6FWFV4sIZmM+3BGFadS9sCaUzMYkspWhwk9314lvHTgSwEubo5qGNs+
         viM9sMmufs6nol24UjxDghM5icl4To5/K87DCJ/lstHJi8QJxz9qWk+QaJo4gyyaSo3W
         EkMJRBJ1hXFzAwzwhUqWAUhOqrY67qIbZe/mlXJ79eS6LQ28qI1kJ7ZxUuUyS8R0XJuM
         OAp8nqZICRluGgsVtPl9M+Zudn7S1d6+LjPJ3k0NGX0lT0GtJvPdIXxKVjwmeMzAzteQ
         ZJfA==
X-Gm-Message-State: APzg51DQSUFyJV9DafEKPiZWk57xM7KF3B0FB6ECk4JNNL+PdVhwy9Sq
        27WPQIiVVjNTg4tWf1BXrZU=
X-Google-Smtp-Source: ANB0VdbXT5ec6PiO1vr4l5lhB1tFetn8PMS6vj1uJXMSApCl6ZIjHI0X+sES3m8MZfFnm3N6mdxuvw==
X-Received: by 2002:a19:fc07:: with SMTP id a7-v6mr3304209lfi.21.1536934093562;
        Fri, 14 Sep 2018 07:08:13 -0700 (PDT)
Received: from xi.terra (c-74bee655.07-184-6d6c6d4.bbcust.telenor.se. [85.230.190.116])
        by smtp.gmail.com with ESMTPSA id i16-v6sm370252lfj.73.2018.09.14.07.08.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 14 Sep 2018 07:08:12 -0700 (PDT)
Received: from johan by xi.terra with local (Exim 4.91)
        (envelope-from <johan@kernel.org>)
        id 1g0olb-0005q7-BQ; Fri, 14 Sep 2018 16:08:15 +0200
Date:   Fri, 14 Sep 2018 16:08:15 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Al Viro <viro@ZenIV.linux.org.uk>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 27/50] opticon: switch to ->get_serial()
Message-ID: <20180914140815.GO1362@localhost>
References: <20180913023119.GQ19965@ZenIV.linux.org.uk>
 <20180913024049.24567-1-viro@ZenIV.linux.org.uk>
 <20180913024049.24567-27-viro@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180913024049.24567-27-viro@ZenIV.linux.org.uk>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 13, 2018 at 03:40:26AM +0100, Al Viro wrote:
> From: Al Viro <viro@zeniv.linux.org.uk>
> 
> Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>

Reviewed-by: Johan Hovold <johan@kernel.org>
