Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC144C07E85
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 12:06:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 85F252084A
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 12:06:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G7ya4Mok"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 85F252084A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=korsgaard.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726533AbeLKMGS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 07:06:18 -0500
Received: from mail-ed1-f42.google.com ([209.85.208.42]:34451 "EHLO
        mail-ed1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726342AbeLKMGR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 07:06:17 -0500
Received: by mail-ed1-f42.google.com with SMTP id b3so12317894ede.1
        for <linux-kernel@vger.kernel.org>; Tue, 11 Dec 2018 04:06:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=Znp5fWWAy+fY33w4v1SIX1Opnal0UAlecYqYJxatWgU=;
        b=G7ya4MokuhiRNJTVwSiLD/0D4Af0Ui1cVwgs3doHLBOkaQAXYTcFjfsdLmTaHiJu4j
         DBhHo4nDDc3TaSpRRoML0UX/eLKMMMWxFmA42mhvMxzi5czDk3D6FeGUBOzEcOJRM0Yu
         G/VYAtWMDhl3LkRu5bAvrurIldwflNkr3Yk8UsPb/julIGqrYFkfk91D24CyofXOJxKP
         48tUsXg5vo2qGTapLmHchr/DUrtMGET75NT1axn4gtpMClT2athhHxNQ6u9MnYQ0CTts
         3M2+XJjvyDASWkt+Cv2avVvm5yBM7KrpjHvrNjn76XXm7DIb0qM0IjHo66ZQiXWEu0XO
         J0IA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=Znp5fWWAy+fY33w4v1SIX1Opnal0UAlecYqYJxatWgU=;
        b=UZxKqcXgP2qSEVzXoLhgf7L0OO+f/wBNyDBuH9J6gnwqOhTetYhCONa1GjRk6quTp7
         J9hhPJ2YJ/BrQ+HOINCdcpaM+9x9L90qmXI1mzw+5Mfeh3Mi8sCi9BdDj1XjxsY/4t6s
         h4CghzRw72kbU6Bwi2FC5PWif4NLaDXHLOBOyv0pSwfIbt2y8OiVOhp217SmMzL6KuwT
         HXhbqoEJz4E3UgzPb4BgM3jY5kGce9l1eLe/vMImhjQ8YL8U9kPii1aG94IkwieywyNp
         Jeak+1eKPEvjNcKugTVn3bRCGLL/DsazJKUEEhT44ibI037sFxWjNfUtnWa8L0W0gXra
         UneQ==
X-Gm-Message-State: AA+aEWb4uhYchkQtms4MfehsF4HJv0CCWZCfe5e9e5+xno0e43HmTuJc
        J78BK+DPTyjR5xZOZge4B/tXuNCd
X-Google-Smtp-Source: AFSGD/XCDVgOICpp4tU9cIMKyo4/gViSCoKGnO1SUwAIT0Lo2D6+zkCLjH2uJoVCvI/gNoEDK1enIA==
X-Received: by 2002:a50:82c7:: with SMTP id 65mr15100213edg.94.1544529975977;
        Tue, 11 Dec 2018 04:06:15 -0800 (PST)
Received: from dell.be.48ers.dk (d51A5BC31.access.telenet.be. [81.165.188.49])
        by smtp.gmail.com with ESMTPSA id p16-v6sm2206672eju.73.2018.12.11.04.06.15
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 11 Dec 2018 04:06:15 -0800 (PST)
Received: from peko by dell.be.48ers.dk with local (Exim 4.89)
        (envelope-from <peter@korsgaard.com>)
        id 1gWgnm-0007VJ-NE; Tue, 11 Dec 2018 13:06:14 +0100
From:   Peter Korsgaard <peter@korsgaard.com>
To:     Jean Delvare <jdelvare@suse.com>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Revert "firmware: dmi_scan: Use lowercase letters for UUID"
References: <20181205211351.5309-1-peter@korsgaard.com>
        <1544086444.5492.1.camel@suse.com> <87a7ljyppx.fsf@dell.be.48ers.dk>
        <1544092087.5492.3.camel@suse.com> <878t1264lf.fsf@dell.be.48ers.dk>
Date:   Tue, 11 Dec 2018 13:06:14 +0100
In-Reply-To: <878t1264lf.fsf@dell.be.48ers.dk> (Peter Korsgaard's message of
        "Thu, 06 Dec 2018 16:46:04 +0100")
Message-ID: <87efaotgi1.fsf@dell.be.48ers.dk>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.5 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "Peter" == Peter Korsgaard <peter@korsgaard.com> writes:

Hi Jean,

 >> Look, you can imagine that I was perfectly aware of what I was doing
 >> when I made that change, and that I pondered the decision carefully at
 >> that time. And my decision was that the change should be made. As far
 >> as I'm concerned, this ship has sailed already, sorry.

 > Sorry, what is the perceived risk of reverting this change? Just the
 > minor inconsistency between the dmidecode and sysfs output? As stated
 > above, the RFC requires conforming parsers to handle upper case as well.

I would appreciate if you could explain what risk you see from reverting
this change?

-- 
Bye, Peter Korsgaard
