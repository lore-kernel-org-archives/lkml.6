Return-Path: <SRS0=Jh2l=L4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CBF4FC6182
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 13:31:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 38B5420671
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 13:31:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qpWBrSTI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 38B5420671
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728268AbeINSqX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Sep 2018 14:46:23 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:37380 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727676AbeINSqX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Sep 2018 14:46:23 -0400
Received: by mail-lj1-f193.google.com with SMTP id v9-v6so7530423ljk.4
        for <linux-kernel@vger.kernel.org>; Fri, 14 Sep 2018 06:31:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=CHheN5KHldEW0GljUdUkvXHMS9oCL0cR4FXlxmukDB0=;
        b=qpWBrSTIKQsiEoEudGlywcLHlK5kQ0p9NrhYPmgIsP/fj5O9C1nXFITTkMgbtrRLWV
         svTzr+/zMb4LiFLhXrk22L6zx3U6veK7avRgCLu6Mb6mrtFsA4CtUM7ISTGxcS9dqFG4
         P28y+4A5tIaZIrlTzmWG+93/QKJfMvYfkqa8H+Roq/wnGmZ6OSaWdraxfjITNvJ3TE8d
         Y0qGdpL0arSaZ4Relw2VenP/dUwh662Iys96nLj9FctomCVrmJeh4rntWr3NCFnTzZoF
         7jwyxQubjW+cbZrgJ7G81QDGN3V87Ce3dorWuZoAAh9zUWuCKF/ejO5aVlrA7jc9Xfzp
         B6vQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=CHheN5KHldEW0GljUdUkvXHMS9oCL0cR4FXlxmukDB0=;
        b=A2DQYH+WYgZNI3nM+ljXDAuTdpz60IYR//q7noPD2SMtX9mX1iidT+6e8U2XvHRcwk
         YORBfbKuyg6smtzcZMlNxS9kz3gXI4MqMfmu4Lc/SVhdtgOXJOUJntvFWbCYTLUm5cIn
         ORkQFEc6+7MKPv4UJUfx15JY/DYe0l3ycozGYrV6y0OclQyzOTQqfnqCvD4xO2sGkir5
         /XqmLEsfdtGmdSOZxrTwfzUv2oSZJss6wL9ibeo9cXyXDZvaD1XQVykpt92+OASgXc9J
         MdFq3l14dhmBrjoPwBDpzDJSMBY+X1EPuuhmCcotQZMqDkbyN+u+f+NDAC5X/v1TLbWN
         Bi5A==
X-Gm-Message-State: APzg51AYln70ixbH1C/lrP3MOEYPJfFqlUudAY7cnmFnKc5TfAjPFDXN
        UTozd488VKjETOrzDdxuQlY=
X-Google-Smtp-Source: ANB0VdbYXPcfUM2oWG0LhtFOv2TohzKMIVn5DYhLgj0gzrIfe+D6xh+5FKtdUglqCtBbgD5N7QtV3g==
X-Received: by 2002:a2e:429c:: with SMTP id h28-v6mr7817926ljf.67.1536931910352;
        Fri, 14 Sep 2018 06:31:50 -0700 (PDT)
Received: from xi.terra (c-74bee655.07-184-6d6c6d4.bbcust.telenor.se. [85.230.190.116])
        by smtp.gmail.com with ESMTPSA id g10-v6sm1290135lfl.11.2018.09.14.06.31.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 14 Sep 2018 06:31:49 -0700 (PDT)
Received: from johan by xi.terra with local (Exim 4.91)
        (envelope-from <johan@kernel.org>)
        id 1g0oCO-0002e4-1p; Fri, 14 Sep 2018 15:31:52 +0200
Date:   Fri, 14 Sep 2018 15:31:52 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Al Viro <viro@ZenIV.linux.org.uk>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 08/50] greybus/uart: switch to ->[sg]et_serial()
Message-ID: <20180914133152.GE1362@localhost>
References: <20180913023119.GQ19965@ZenIV.linux.org.uk>
 <20180913024049.24567-1-viro@ZenIV.linux.org.uk>
 <20180913024049.24567-8-viro@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180913024049.24567-8-viro@ZenIV.linux.org.uk>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 13, 2018 at 03:40:07AM +0100, Al Viro wrote:
> From: Al Viro <viro@zeniv.linux.org.uk>
> 
> Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>

Reviewed-by: Johan Hovold <johan@kernel.org>
