Return-Path: <SRS0=Clcj=JE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.5 required=3.0 tests=DKIM_ADSP_ALL,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94EE9C433EF
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 05:34:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 347D020864
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 05:34:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gregn.net header.i=@gregn.net header.b="Xfbl7umq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 347D020864
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gregn.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754539AbeFRFeu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Jun 2018 01:34:50 -0400
Received: from vserver.gregn.net ([174.136.110.154]:37132 "EHLO
        vserver.gregn.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752361AbeFRFet (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jun 2018 01:34:49 -0400
Received: from vbox.gregn.net (unknown [IPv6:2001:470:d:6c5:dccc:19d1:b333:b8a8])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by vserver.gregn.net (Postfix) with ESMTPSA id 5BED422DA;
        Sun, 17 Jun 2018 22:35:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=gregn.net; s=default;
        t=1529300119; bh=pOA7Phcl9YSRIPc+RMMCmwSir5FCHjLqAit2LEqUeoY=;
        h=Date:From:To:Subject:References:In-Reply-To:From;
        b=Xfbl7umqrN1dKBXC7g9ycCuzXnfravJ0T6WbODVcg+qRSjhulC/60A72Q09Fcs0MA
         3u0STLzHxoIvHX7rPLAt+Xi6Ff8WIokih2WoEA0q7il9zbaQpLwDzfuWW2jfkgIwFn
         IT9Y0wiOrCiVXIdxEpp21QUwVaNgRPv7N5Og3id39JPH9fhY7Hr2gIn2S1WpXyABMD
         yyE81qogwGHAM9MTRRrYcrOElG45s9WMCTczfXPChmBBKNxNy6JwfDfUlcZMit7GiR
         KPGv9KGZnqapi4akuifRO0SBZa1YjKy0OOplquAOCvyoD5yuQhs3eCjt0NpW4lFv6Y
         qVRI6YvDfDnZA==
Received: from greg by vbox.gregn.net with local (Exim 4.84_2)
        (envelope-from <greg@gregn.net>)
        id 1fUmoO-0001pZ-Sw; Sun, 17 Jun 2018 22:34:44 -0700
Date:   Sun, 17 Jun 2018 22:34:44 -0700
From:   Gregory Nowak <greg@gregn.net>
To:     Samuel Thibault <samuel.thibault@ens-lyon.org>,
        "Speakup is a screen review system for Linux." 
        <speakup@linux-speakup.org>, devel@driverdev.osuosl.org,
        gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: speakup: refactor synths array to use a list
Message-ID: <20180618053444.GA1614@gregn.net>
References: <20180604095212.GA18381@tanglefoot>
 <20180606132628.fxykchbznrwzgwqt@var.youpi.perso.aquilenet.fr>
 <20180611225703.csi47cdafhy6rxcf@var.youpi.perso.aquilenet.fr>
 <20180611235122.GA28343@gregn.net>
 <20180612063105.7urgjfckrwjvqs6k@var.youpi.perso.aquilenet.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180612063105.7urgjfckrwjvqs6k@var.youpi.perso.aquilenet.fr>
X-PGP-Key: http://www.gregn.net/pubkey.asc
User-Agent: Mutt/1.5.23 (2014-03-12)
X-Virus-Scanned: clamav-milter 0.99.4 at vserver
X-Virus-Status: Clean
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 12, 2018 at 08:31:06AM +0200, Samuel Thibault wrote:
> The load/unload is about the module itself, i.e. modprobe speakup_bns ;
> modprobe speakup_soft, switch between them, then rmmod speakup_bns ;
> speakup_soft or the converse (to exercise both orders).

# uname -a
Linux p41box 4.17.1 #1 SMP Sat Jun 16 11:19:57 MST 2018 i686 GNU/Linux
# lsmod |grep "speakup"
speakup_bns            16384  0
speakup_soft           16384  1
speakup                94208  3 speakup_bns,speakup_soft

With /sys/accessibility/speakup/synth set to bns, I am getting output
alternately from the bns and from soft. It's as if speakup can't make
up its mind which synthesizer is being used. When I echo soft
>/sys/accessibility/speakup/synth, I get no speech at all from either
synthesizer. Doing rmmod of all three speakup modules comes back with
no errors. There is also no unusual output in dmesg, I can see both
synthesizers being registered and unregistered as I switch between
them.

I can also reproduce this behavior with speakup_soft, and speakup_dummy
specifically:

1. modprobe speakup_soft and modprobe speakup_dummy

2. The synthesizer should now be set to dummy in
   /sys/accessibility/speakup/synth.

3. Use the speakup review keys, press enter a number of times. You
   should observe output from both the software speech, and from the
   serial port alternating between each other.

4. echo soft >/sys/accessibility/speakup/synth

5. You should observe no output from either software speech or the
   serial port as you use speakup review keys, or press enter
   repeatedly.

6. echo dummy >/sys/accessibility/speakup/synth

7. You should alternately get speech from the software synthesizer and
   from the serial port.

I built my kernel from the 4.17.1 kernel.org sources, and the patch
that Samuel reposted applied cleanly with no errors.

Greg


-- 
web site: http://www.gregn.net
gpg public key: http://www.gregn.net/pubkey.asc
skype: gregn1
(authorization required, add me to your contacts list first)
If we haven't been in touch before, e-mail me before adding me to your contacts.

--
Free domains: http://www.eu.org/ or mail dns-manager@EU.org
