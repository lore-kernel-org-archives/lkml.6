Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F76AC32789
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 13:08:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2C1F32081D
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 13:08:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2C1F32081D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726869AbeKHWny (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Nov 2018 17:43:54 -0500
Received: from mail-ot1-f67.google.com ([209.85.210.67]:35570 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726417AbeKHWny (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Nov 2018 17:43:54 -0500
Received: by mail-ot1-f67.google.com with SMTP id 81so18066041otj.2;
        Thu, 08 Nov 2018 05:08:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=dnPM+0kKtrlsbW/UsAeyw/BnIXUEN2gJ2Vu5cw0lhW4=;
        b=j4LonYExSmNTBMfxcMzsV/rwQwIja3dNAdD5W+rAkKboHVYKcT+SF0ZuPcNPi3NkrR
         1j0GAlpD/NqUS3Szq96d9qOkgnVDaF75FdiISA+mbdbgS9v5Ru0OPduQBu22rmkpyxyQ
         cTJD1GfxbUwDmQm0D9hhxOkN9a/fPNx3BgG+GVuzYpjAZ379PmG8O6u7oAXGWauKaeRC
         DoMkY+NnKqb0ToqVL3YqE+so7+ZotN6RgoFn0ymxAGcCoS9JLUTeG+cL/E/rYtJA5pYh
         gluiv5utbVHTeZoU9/NRd1V/GzQi0nbQhLnigkKseIo/10xIG23uIf4Z7RUIe8bP82lL
         y1aA==
X-Gm-Message-State: AGRZ1gLcBCztwKRunRvfEGf7ug9dF50WjbvvKfSdDsPyt2v/AJetQ71M
        q9Bwopc1FB/aPJRDDJjnWw==
X-Google-Smtp-Source: AJdET5d+Yx13DgS8omJbL2O8gGpDSo86DjhM7k1SwmqeDt7ij7Qn2/Tn6uMteBVF1dNMT4XUGqfzcw==
X-Received: by 2002:a9d:5755:: with SMTP id x21mr2805773oti.193.1541682507898;
        Thu, 08 Nov 2018 05:08:27 -0800 (PST)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id p8sm1517378otl.2.2018.11.08.05.08.27
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 08 Nov 2018 05:08:27 -0800 (PST)
Date:   Thu, 8 Nov 2018 07:08:26 -0600
From:   Rob Herring <robh@kernel.org>
To:     John Garry <john.garry@huawei.com>
Cc:     frowand.list@gmail.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linuxarm@huawei.com,
        will.deacon@arm.com, anshuman.khandual@arm.com,
        peterz@infradead.org
Subject: Re: [PATCH v2] of, numa: Validate some distance map rules
Message-ID: <20181108130826.GA18544@bogus>
References: <1541672223-131326-1-git-send-email-john.garry@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1541672223-131326-1-git-send-email-john.garry@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 08, 2018 at 06:17:03PM +0800, John Garry wrote:
> Currently the NUMA distance map parsing does not validate the distance
> table for the distance-matrix rules 1-2 in [1].
> 
> However the arch NUMA code may enforce some of these rules, but not all.
> Such is the case for the arm64 port, which does not enforce the rule that
> the distance between separates nodes cannot equal LOCAL_DISTANCE.
> 
> The patch adds the following rules validation:
> - distance of node to self equals LOCAL_DISTANCE
> - distance of separate nodes > LOCAL_DISTANCE
> 
> This change avoids a yet-unresolved crash reported in [2].
> 
> A note on dealing with symmetrical distances between nodes:
> 
> Validating symmetrical distances between nodes is difficult. If it were
> mandated in the bindings that every distance must be recorded in the
> table, then it would be easy. However, it isn't.
> 
> In addition to this, it is also possible to record [b, a] distance only
> (and not [a, b]). So, when processing the table for [b, a], we cannot
> assert that current distance of [a, b] != [b, a] as invalid, as [a, b]
> distance may not be present in the table and current distance would be
> default at REMOTE_DISTANCE.
> 
> As such, we maintain the policy that we overwrite distance [a, b] = [b, a]
> for b > a. This policy is different to kernel ACPI SLIT validation, which
> allows non-symmetrical distances (ACPI spec SLIT rules allow it). However,
> the distance debug message is dropped as it may be misleading (for a distance
> which is later overwritten).
> 
> Some final notes on semantics:
> 
> - It is implied that it is the responsibility of the arch NUMA code to
>   reset the NUMA distance map for an error in distance map parsing.
> 
> - It is the responsibility of the FW NUMA topology parsing (whether OF or
>   ACPI) to enforce NUMA distance rules, and not arch NUMA code.
> 
> [1] Documents/devicetree/bindings/numa.txt
> [2] https://www.spinics.net/lists/arm-kernel/msg683304.html
> 
> Cc: stable@vger.kernel.org # 4.7
> Signed-off-by: John Garry <john.garry@huawei.com>
> Acked-by: Will Deacon <will.deacon@arm.com>
> ---

Applied, thanks.

Rob
