Return-Path: <SRS0=qqIy=KO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68E20FD21E1
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 14:10:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 15BC220870
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 14:10:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="o0wW/2xQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 15BC220870
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729283AbeG3PqG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Jul 2018 11:46:06 -0400
Received: from mail-yw0-f194.google.com ([209.85.161.194]:38534 "EHLO
        mail-yw0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726765AbeG3PqG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jul 2018 11:46:06 -0400
Received: by mail-yw0-f194.google.com with SMTP id r3-v6so4392405ywc.5;
        Mon, 30 Jul 2018 07:10:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=eWRTwL/5+4+PhEBsNLIiCHp2Gqle593wB1wxCVEjlA8=;
        b=o0wW/2xQXez0KwYI1xGVc6hbSEWgbt1jgScUbWG3n2ShaUEoRNJrv8VhGsruMFjVji
         OVPQ/UbFZ+ibreKCXUDCD74VZ4+HgGrLfbnqpKnTIcYkTV2G4Z7gUGKSHmxpSgvUKCYm
         qRCWdzqeIQs9oVu2GpQgmi/zRuVwmL4Gkz/9xOt5NTQGFS5X03TM/K3BI+us7i1IF29T
         UoyCFiikCY2kg2IHBolNmSPbKYvK4Co4v483LiUU78gA6rz3tvuJdB4eLvzz6HZuSDjJ
         JU9q4geQ3/XJKFtZbg69Egc5f/dLt/BLgE8SHJEYexRXaj/UH9EdI3DHsKs4XkIJ7wBW
         dyJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=eWRTwL/5+4+PhEBsNLIiCHp2Gqle593wB1wxCVEjlA8=;
        b=j1rvpKqM90wOy4IopKt+OlEozy5gPwwDH12TQCPOh1gjOEZKarF+SvchKAp7j6awd2
         SxxVAdS63WueqNwA0PmNhe5XuwUnGB1s2lJ6wSarL0rF4Z11L2W/zZG0USSHPwUgtzZA
         DgDWDTiCal+OFHS1bEQdx2hnI7EhsLs82Oe3LoxyjUUDH/rphkntRkVzZlWvnZUrZLeb
         572btm5rMwClQaZ7ftw9zFsMlf6YnaCG/dFg+kTLB2V4xoKs1sCiq1niVmpm4u+suQBy
         BEbzciJlCyEZKrY9f9erd9P1lJNjELK1RgfBgc3sLkuJq9HH6QQcQyRrlZvBeJmTzbTR
         o28w==
X-Gm-Message-State: AOUpUlGI0DDUoEwfrgIQvvEKukKpopSdO5CyJLJ4WLumXnBOvk9hzkYE
        KF1nRegYoEQY2XpC7S6coaU=
X-Google-Smtp-Source: AAOMgpcLb5w3BbbCmcWwHpOer8vqIWBeoBvBHG35hplTWKmItsiE4EaxDSqHtOHCS+WQwGB7iJ6slw==
X-Received: by 2002:a0d:f506:: with SMTP id e6-v6mr6779777ywf.298.1532959854887;
        Mon, 30 Jul 2018 07:10:54 -0700 (PDT)
Received: from localhost ([2620:10d:c091:200::2:4bfe])
        by smtp.gmail.com with ESMTPSA id i67-v6sm11270136ywc.27.2018.07.30.07.10.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 30 Jul 2018 07:10:53 -0700 (PDT)
Date:   Mon, 30 Jul 2018 07:10:52 -0700
From:   Tejun Heo <tj@kernel.org>
To:     Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc:     hdegoede@redhat.com, rjw@rjwysocki.net, alan.cox@intel.com,
        linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, Mario.Limonciello@dell.com
Subject: Re: [PATCH v2 0/2] ata: ahci: Enable DEVSLP by default on SLP_S0
 support
Message-ID: <20180730141052.GB1206094@devbig004.ftw2.facebook.com>
References: <20180727204703.6505-1-srinivas.pandruvada@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180727204703.6505-1-srinivas.pandruvada@linux.intel.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 27, 2018 at 01:47:01PM -0700, Srinivas Pandruvada wrote:
> One of the requirement for modern x86 system to enter lowest power mode
> (SLP_S0) is SATA IP block to be off. This is true even during when
> platform is suspended to idle and not only in opportunistic (runtime)
> suspend.
> This series is to enable DEVSLP by default.

Applied to 1-2 to libata/for-4.19.

Thanks.

-- 
tejun
