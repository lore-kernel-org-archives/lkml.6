Return-Path: <SRS0=aB5v=OC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B709EC43441
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 11:03:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7CA2820820
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 11:03:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="ryaooX5w"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7CA2820820
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2409563AbeKWVqx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 23 Nov 2018 16:46:53 -0500
Received: from mail-ed1-f67.google.com ([209.85.208.67]:45412 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2409549AbeKWVqw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Nov 2018 16:46:52 -0500
Received: by mail-ed1-f67.google.com with SMTP id d39so9898711edb.12
        for <linux-kernel@vger.kernel.org>; Fri, 23 Nov 2018 03:03:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=yhP3K5HcdfCAroFnskVcIMJwgZFxlm2bTaNNpGRRNuo=;
        b=ryaooX5wX3a9ydWWXNkvQO4MUpyhXUVZ5b+DARtO0BtVYhCNWm1APWnId9dyEEKgLq
         4yaEBwZTcUDgFZ4gdaSbr4h9vP9sWPZoFs/ddlVR8aF9ayyhyZ1bM+XrOgPSZDuaQ8S2
         7nKZzhULOjGX2gromiqauwNkKKEFwr1qkzqlM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=yhP3K5HcdfCAroFnskVcIMJwgZFxlm2bTaNNpGRRNuo=;
        b=T0R/ZgINCT9CwkMLjJdPTxQgvSDiD1IxO6C03Hbc3lXlmdb8gSsvY1kWIVYs2uTzhF
         /7tLbvqJdQS1m5KOLdTmqb+5FFkNrTt383K13byLDU1GiuylDTju6coM6L5iL9e3Vkdr
         OgeOpoNWqr8Qzi3atJW0JKGLL+jM1m15P+iJWVSd8UPyzAILIehQCM9eYRc3btxxVDGN
         04ddIEDmDvY6jrpsA/eS1r37VHtZXaGHcUBAfBtMIbgpca97BabVl+NrnFdFXiiR0EKv
         AlPLbTRF/G0EQztSEmeImGFB220wWc+TB3dBW/wN+YwutENMHiBVXNKEV804MDfrM4uT
         ZiXA==
X-Gm-Message-State: AGRZ1gJzwkNSSPLG6133bFwyy2cosfUgEae0jmPTiRm0bWwxFoVGBFs5
        RcAGKJQ2eFT0UXtCSD0cHQmCYg==
X-Google-Smtp-Source: AJdET5dPVQu9PmfOF6gU3yf5qrR63cEefAhKQsMXf85d7UURA4N3SWSLQ+9eoL4yByQjqYwFVJtlTg==
X-Received: by 2002:a17:906:1353:: with SMTP id x19-v6mr11182468ejb.23.1542970982865;
        Fri, 23 Nov 2018 03:03:02 -0800 (PST)
Received: from andrea (85.100.broadband17.iol.cz. [109.80.100.85])
        by smtp.gmail.com with ESMTPSA id s19-v6sm2647240ejz.2.2018.11.23.03.03.01
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 23 Nov 2018 03:03:02 -0800 (PST)
Date:   Fri, 23 Nov 2018 12:02:55 +0100
From:   Andrea Parri <andrea.parri@amarulasolutions.com>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     zhe.he@windriver.com, catalin.marinas@arm.com, tglx@linutronix.de,
        rostedt@goodmis.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org,
        boqun.feng@gmail.com
Subject: Re: [PATCH v2] kmemleak: Turn kmemleak_lock to raw spinlock on RT
Message-ID: <20181123110226.GA5125@andrea>
References: <1542877459-144382-1-git-send-email-zhe.he@windriver.com>
 <20181123095314.hervxkxtqoixovro@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181123095314.hervxkxtqoixovro@linutronix.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> is this an RT-only problem? Because mainline should not allow read->read
> locking or read->write locking for reader-writer locks. If this only
> happens on v4.18 and not on v4.19 then something must have fixed it.

Probably misunderstanding, but I'd say that read->read locking is "the
norm"...?

If you don't use qrwlock, readers are also "recursive", in part.,

  P0			P1
  read_lock(l)
			write_lock(l)
  read_lock(l)

won't block P0 on the second read_lock().  (qrwlock somehow complicate
the analysis; IIUC, they are recursive if and only if in_interrupt().).

  Andrea


>  
> 
> Sebastian
