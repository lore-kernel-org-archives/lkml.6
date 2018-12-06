Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46BA1C04EB9
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 09:22:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CEDC220850
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 09:22:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bryVDwDv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CEDC220850
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=korsgaard.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729271AbeLFJWW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Dec 2018 04:22:22 -0500
Received: from mail-ed1-f65.google.com ([209.85.208.65]:39991 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727763AbeLFJWW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Dec 2018 04:22:22 -0500
Received: by mail-ed1-f65.google.com with SMTP id d3so150033edx.7
        for <linux-kernel@vger.kernel.org>; Thu, 06 Dec 2018 01:22:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=Y1Mlu7qb1AiYxX+6iMv9nonpeVP5x7XtVoO7OXGW/Pc=;
        b=bryVDwDv14xDBn0J73T2zKBz/LSepvSjPZncU/i6UJPGyueBue8pMhz/h4QnbJMXpS
         J/6+AQeeaxNdlse+e+vU3s8izen4OJZu6VzQaXjRM7sSJJwgGL6/6+U017oWjzIDZlqc
         kNN3krwhnmlsddwWcLjOlI5D2jrQCe8E5iy3xuuPu0d9HQJxl0ogZs9AhVpFWWmmwe3Z
         sJtWyvewwofGU7mtjk7FshWgCxFZmNddiDvYSUlX1TYsPGmD1Zeq7NXlHfOAcq8A4cu+
         MyFNhEY60hnes7pG5cnMY0S1pM+6Ui97wNtOsMy7k9727rbHZHo9cfQJzEaYOVvzmRu+
         ajTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=Y1Mlu7qb1AiYxX+6iMv9nonpeVP5x7XtVoO7OXGW/Pc=;
        b=TRehm3iidKkL+ymUtEm/DRwhzK5bmN3Zntw+R3KurFbjAq03gc1pAG5WtLqVHazH8P
         gsoRpm/B3wru3tP9wNjU84Lg9J6N3jfYnfDxCwI3MH/S8a4ViBp9V5ZsJdEh37FpoCy3
         LMj+LA8TIebtTfaWDivpmBuaQsMp0OhDz68+y5bziQjIfeEiM0e1kbduuDjfl+uHlpN3
         zFyVILPNzsdXFwqbfOqgf8PfimDFCd4Zx0Z8ddos8HN++4gYW0P7Ly5FAInvbqPGnAUO
         dvpgwMKUcU/02kVPJpRQ+sjj0YPbzSy2J7rbng5yMLbP5zjqOd3YkVtIgPaL+CZiVFyv
         ybqA==
X-Gm-Message-State: AA+aEWa50jZvKh+A95QSuY3nUhDhrMdr12YmtiKZIYkiJIr8dujMT6AR
        4AB9oPfx/O+023UUA3r1ogiz6ukh
X-Google-Smtp-Source: AFSGD/WyRvmcjS83Q4T2gs38FpyWsGrgJLElmdPvu1KVujOtjLplYjh0IbN7DwIVTMr+ub+Gx0GC/g==
X-Received: by 2002:a50:ba3d:: with SMTP id g58mr24240049edc.35.1544088140328;
        Thu, 06 Dec 2018 01:22:20 -0800 (PST)
Received: from dell.be.48ers.dk (d528f5fe4.static.telenet.be. [82.143.95.228])
        by smtp.gmail.com with ESMTPSA id v43sm44911edc.18.2018.12.06.01.22.19
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 06 Dec 2018 01:22:19 -0800 (PST)
Received: from peko by dell.be.48ers.dk with local (Exim 4.89)
        (envelope-from <peter@korsgaard.com>)
        id 1gUprO-0001n2-Fg; Thu, 06 Dec 2018 10:22:18 +0100
From:   Peter Korsgaard <peter@korsgaard.com>
To:     Jean Delvare <jdelvare@suse.com>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Revert "firmware: dmi_scan: Use lowercase letters for UUID"
References: <20181205211351.5309-1-peter@korsgaard.com>
        <1544086444.5492.1.camel@suse.com>
Date:   Thu, 06 Dec 2018 10:22:18 +0100
In-Reply-To: <1544086444.5492.1.camel@suse.com> (Jean Delvare's message of
        "Thu, 06 Dec 2018 09:54:04 +0100")
Message-ID: <87a7ljyppx.fsf@dell.be.48ers.dk>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.5 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "Jean" == Jean Delvare <jdelvare@suse.com> writes:

 > On Wed, 2018-12-05 at 22:13 +0100, Peter Korsgaard wrote:
 >> This reverts commit 712ff25450bd01366301eef81c33e865d901e7b7.
 >> 
 >> The output of dmi_save_uuid() is exposed to user space as
 >> /sys/devices/virtual/dmi/id/*_uuid, so this breaks backwards compatibility,
 >> E.G.  I have systems that include the content of dmi/id/product_uuid as part
 >> of the keyphrase for cryptsetup luksOpen.
 >> 
 >> As the change was purely cosmetical, revert it to fix such breakage.

 > The change is not "cosmetical". The change was done to comply with RFC
 > 4122:

 > https://tools.ietf.org/html/rfc4122

 >   The hexadecimal values "a" through "f" are output as
 >   lower case characters and are case insensitive on input.

I get that - but it changes the content of sysfs entries, breaking real
systems - E.G. a user space ABI regression.

It is a cosmetic code change in the sense that no known software was
broken with the upper case characters.


 > If "cryptsetup luksOpen" does not lowercase digits before computing its
 > key passphrase, then it's not RFC 4122-compliant and should be fixed.

cryptsetup naturally doesn't know anything about RFC 4122. It just reads
a disk encryption keyphrase which happen to include the content of
id/product_uuid because of my scripts.

 > Nak. This is too late. Changing it again would just add confusion.

Please reconsider. 4.17 is from June, and 4.19 has only recently become
LTS.

-- 
Bye, Peter Korsgaard
