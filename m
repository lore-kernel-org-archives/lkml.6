Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Google-Smtp-Source: AH8x227aqVWNF5hJAC5lhp4oODFk3KIlVw4EEEnSHTm3sz8AUME0c2pbEFBWDXbghmZ7SeDRdPlP
ARC-Seal: i=1; a=rsa-sha256; t=1518373474; cv=none;
        d=google.com; s=arc-20160816;
        b=t7PQDStkmRsW4r7SXj6WBcmW9acl66EGWnQi/zHVXOORUgzeNS1GF7XQFV9lnSRyZD
         evrfZkD9J7dJsPG7y1/KF6FCAV9Vufq1deFTkl+5Xuz1UGxXG84ispFsVo2kyaybOvT2
         9gm9zztsMbzvdGewNNeAU1oNFe40S3tvoGKxZ19IriH4WifCxmtNbpaUEm0K31z/VITH
         CbIJLwtSmPmmvqz5jnDjb0HxKU5alF4/5tkycIcNUDCpMlPy9YCs7/yAXiG5nWTL5HU5
         36Bqw7mGsbmVRoy4y7MTaJI9dMAOAJub24MG10Af+dnMRJr3Cntd0pWZbLAy/3Tnz7CD
         K8VA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=list-id:precedence:sender:user-agent:in-reply-to
         :content-disposition:mime-version:references:message-id:subject:cc
         :to:from:date:dkim-signature:arc-authentication-results;
        bh=vAufqJXrHwvQbXOD2PV3v542buy48adJJdhJrGVz8Wk=;
        b=lubNte8HObQrogfdZrF73uZsAZ0ET7EQue0dKY2V3z2HO4noVbYDZpA8xLIqaO8BJ5
         ZpunonrhADsP30tdqm+4aPCetPh1zCNsk/Va5hT2LiSQ2/amrcG/b+RGdP3bdCX5iEp5
         Qg1BJgwuk7eX4f4jSBx038QzGCGavqhlwtKrCEYe91R8qNDBH1znaXRxl6RdJhWiDYVG
         +51cHhP/b9UxL1ntcCvbCcAkTv/RBCS6Lafux81OVr15dbUv6/detmeOAUoFRsA/EpVT
         3ccbrR8h11aiahjN6PR6/xv6kI3KM+Llpf4JcofUj8fnuMO7dhgcNjfvBNSoVHO8mVb7
         30tg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=neutral (body hash did not verify) header.i=@gmail.com header.s=20161025 header.b=q1jsQdzv;
       spf=pass (google.com: best guess record for domain of linux-kselftest-owner@vger.kernel.org designates 209.132.180.67 as permitted sender) smtp.mailfrom=linux-kselftest-owner@vger.kernel.org
Authentication-Results: mx.google.com;
       dkim=neutral (body hash did not verify) header.i=@gmail.com header.s=20161025 header.b=q1jsQdzv;
       spf=pass (google.com: best guess record for domain of linux-kselftest-owner@vger.kernel.org designates 209.132.180.67 as permitted sender) smtp.mailfrom=linux-kselftest-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753594AbeBKSYd (ORCPT <rfc822;gregkh@linuxfoundation.org>);
        Sun, 11 Feb 2018 13:24:33 -0500
Received: from mail-wr0-f196.google.com ([209.85.128.196]:44844 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753589AbeBKSYc (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sun, 11 Feb 2018 13:24:32 -0500
Date: Sun, 11 Feb 2018 19:24:28 +0100
From: Ingo Molnar <mingo@kernel.org>
To: Dominik Brodowski <linux@dominikbrodowski.net>
Cc: linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        x86@kernel.org, shuah@kernel.org,
        Andrew Lutomirski <luto@kernel.org>
Subject: Re: [PATCH 2/5] selftests/x86: fix vDSO selftest segfault for
 vsyscall=none
Message-ID: <20180211182428.e7isprkt6hbuq3dk@gmail.com>
References: <20180211111013.16888-1-linux@dominikbrodowski.net>
 <20180211111013.16888-3-linux@dominikbrodowski.net>
 <20180211112153.f2ni5mcuut6f6zvq@gmail.com>
 <20180211121714.GA11096@isilmar-4.linta.de>
 <20180211130029.GA23754@light.dominikbrodowski.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180211130029.GA23754@light.dominikbrodowski.net>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kselftest-owner@vger.kernel.org
X-Mailing-List: linux-kselftest@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1592102766376680865?=
X-GMAIL-MSGID: =?utf-8?q?1592129984127334853?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>


* Dominik Brodowski <linux@dominikbrodowski.net> wrote:

> On Sun, Feb 11, 2018 at 01:17:14PM +0100, Dominik Brodowski wrote:
> > On Sun, Feb 11, 2018 at 12:21:53PM +0100, Ingo Molnar wrote:
> > > 
> > > * Dominik Brodowski <linux@dominikbrodowski.net> wrote:
> > > 
> > > > +		char name[128];
> > > > +		if (sscanf(line, "%p-%p %c-%cp %*x %*x:%*x %*u %s",
> > > > +			   &start, &end, &r, &x, name) != 5)
> > > 
> > > So that's a buffer overflow waiting to happen, if a line in 'maps' gets too large, 
> > > right?
> > 
> > ... as does tools/testing/selftests/x86/test_vsyscall.c already now, right?
> > Will fix both up with an additional patch.
> 
> Maybe no fix is needed after all: The fgets() call a few lines above
> limits "line" to 127 chars max. So "name" can't even get close to 128
> chars, right?
> 
> 	char line[128];
> ...
> 	while (fgets(line, sizeof(line), maps)) {

Yeah, probably - but still, this connection and the sscanf() guarantee is not 
obvious at first sight, so please improve this to derive from the same value 
(define a LINE_MAX size or such), plus maybe add a comment to the sscanf() line 
that this is safe because strlen(name) >= strlen(line).

Thanks,

	Ingo
