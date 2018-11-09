Return-Path: <SRS0=IvFc=NU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E9AAC43441
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 12:38:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0A45720883
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 12:38:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l8jOBUV5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0A45720883
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727978AbeKIWSd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Nov 2018 17:18:33 -0500
Received: from mail-pg1-f174.google.com ([209.85.215.174]:44949 "EHLO
        mail-pg1-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727662AbeKIWSc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Nov 2018 17:18:32 -0500
Received: by mail-pg1-f174.google.com with SMTP id w3-v6so795621pgs.11;
        Fri, 09 Nov 2018 04:38:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=wsWzgrMATgI/+f6lNg93g25tbg6I6jFoED3IS9sdVoo=;
        b=l8jOBUV56xklZzGSLsFp8o9bmLdAUh5m4HEM3mkw6b5etWTNp0RrjP+MgOZIupPK8N
         6CyP830PpdBLoxPSRLHMWeqhoOq9lG6Wg1tkncpI1FWHXDUj1hNpWWFCOSx+E4FjKWj0
         BLtKPLSRTZGwQg5787mD7B+vao/o0TPCoiogI5W/e+Np8BgvLNfS5F+evgJsOMFuBptD
         wEHKEQjy/vkIPpLFb2LKHgwMPc1OtBjyPjNUmGB0EaJAUHwrw7HxVWULISrZUhRAau+0
         O0BH3y9h/GVZMbdyilkDyhYtQRVWwC+h3KfBwKASvPhWX6xAQT84pVujqvRJpZ9aPiWR
         A+Mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=wsWzgrMATgI/+f6lNg93g25tbg6I6jFoED3IS9sdVoo=;
        b=kaaOvDhnEZUkbTbqAvk+DDWsmOHJD2v3xn2sLU2EapFDqk8Xua4LB5uhiFeo3XXZRl
         DfiCm7ibn56z8s1VfL1hr39qjSmWpvg8APFS0hkSTzo7uSwFRDjI/tkRddgTRi0g7Lt7
         Qdy5VugCw49vjD15LuC4nfyeg4e35mFq4LKOdH8J3gNYyQKYg9kQs8JDwHBT8R+DZ0Nh
         8E5J1aB4xCvRG3qnhL1Oq1wjwvYvHD8D38iOxLrau5GLnAGIhnsMEvwI0v8dH1cqMH4G
         SfN/bN5wtSkjRDEezq3ZQrgntpGpQ3x/tSPbCuiNFlU2kHLsQgvlUmE5iO1fYoA0BW9B
         ew2w==
X-Gm-Message-State: AGRZ1gKwaYdiMmG3mkqGWjx12V9ZqooWtRusypRAzWprTQ788FKLML1q
        O1yofUFtVwP14q9QZvRcwYk=
X-Google-Smtp-Source: AJdET5dZbATPZGNr/nbNiA4zF9dSEQ6qfoELa7BFzYtCb0PQWFfAWxuUT06cI3RDzcG9R+a26+2jUw==
X-Received: by 2002:a63:9306:: with SMTP id b6mr7060815pge.36.1541767085368;
        Fri, 09 Nov 2018 04:38:05 -0800 (PST)
Received: from suraj-Inspiron-5370.nitk.ac.in ([2409:4071:211d:4f4e:b056:9584:f527:78d6])
        by smtp.gmail.com with ESMTPSA id q25sm9135897pgb.2.2018.11.09.04.37.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 09 Nov 2018 04:38:04 -0800 (PST)
From:   Suraj Singh <suraj1998@gmail.com>
To:     davem@davemloft.net
Cc:     kuznet@ms2.inr.ac.ru, yoshfuji@linux-ipv6.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        suraj1998@gmail.com
Subject: Re: net: ipv4: tcp_vegas
Date:   Fri,  9 Nov 2018 18:07:48 +0530
Message-Id: <1541767068-3432-1-git-send-email-suraj1998@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1541665792-5888-1-git-send-email-suraj1998@gmail.com>
References: <1541665792-5888-1-git-send-email-suraj1998@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I'm extremely sorry if I have seemed unresponsive to you but it took me a 
while to figure out how to respond to threads using the corresponding mail
-id. I think the first two comments that you wrote on my initial patch with 
message-id: 1541425985-31869-1-git-send-email-suraj1998@gmail.com were being
redirected to my spam folder and since I didn't have mutt configured
then, I didn't see them, 


The reason I've been prefixing all the subject of my mails with "staging: "
is because I was following Greg Kroah-Hartman's YouTube video on how to 
submit your first kernel patch. I didn't realise the significance of using
it and didn't take the time out to understand what it really meant and that
is my bad. I've got clarifications for the same in comments to the patch with 
message-id: 1541670377-17483-1-git-send-email-suraj1998@gmail.com

I think what I will do is first figure out how to use mutt effectively before
sending subsequent patches and emails because all the emails that I have sent 
(including this one), I've done so by manually writing git send-mail commands 
in response to the corresponding message-id. 

Other than unwarranted "staging: " in the subject, are there any other changes
that need to be made before I submit [v3] of the second tcp_westwood patch
(1541670377-17483-1-git-send-email-suraj1998@gmail.com)? 

Regards,
Suraj
