Return-Path: <SRS0=cBqk=QM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B269C282CB
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 22:32:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 29DC32077B
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 22:32:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549405925;
	bh=wOvcA1CxjKZ6PmqOzv5o/xpdorhXhJKm4qvjhIcPK5w=;
	h=Subject:From:Cc:References:To:In-Reply-To:Date:List-ID:From;
	b=WwnrNfM6cw1Xp59A9ZTgjU3LVQgYHXW214uF5cuzuFobGBIN48hvyBZXVZA7Npv2e
	 u1D8KudecR0YTMWuaQoRD6Xuj+rhm6GGeeFiICjrxuplDj391vAPDuS29B40FTkJ5n
	 bmeORTqO7HIobYq59o5o2E35u9rVPagtkfNWgkSA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727853AbfBEWcD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Feb 2019 17:32:03 -0500
Received: from mail.kernel.org ([198.145.29.99]:38950 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726606AbfBEWcD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Feb 2019 17:32:03 -0500
Received: from localhost (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1117F2077B;
        Tue,  5 Feb 2019 22:32:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549405922;
        bh=wOvcA1CxjKZ6PmqOzv5o/xpdorhXhJKm4qvjhIcPK5w=;
        h=Subject:From:Cc:References:To:In-Reply-To:Date:From;
        b=1afT2NK/N9YwZXNohXM+mjjGybRKi0oPh3jNgDA9wb3p+k9Kq5GYj9iTVPoXBg7Sk
         bwOBXUTVSXl1yOejt+lTr6WYaWyIRrmPvUMMxvu1lYY4qG7x2OIV1n3k6iH3dfA2P4
         JRW88q8cPFetzrdGLGHWMhxsF9xMPEXxmoK/PTlg=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v1 1/4] clk: qcom: smd: Add XO clock for MSM8998
From:   Stephen Boyd <sboyd@kernel.org>
Message-ID: <154940592132.169292.15811923452101983358@swboyd.mtv.corp.google.com>
Cc:     marc.w.gonzalez@free.fr, andy.gross@linaro.org,
        david.brown@linaro.org, robh+dt@kernel.org, mark.rutland@arm.com,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        georgi.djakov@linaro.org
References: <1548866102-30224-1-git-send-email-jhugo@codeaurora.org> <1548866144-30265-1-git-send-email-jhugo@codeaurora.org> <154940408967.169292.15276398799323074789@swboyd.mtv.corp.google.com> <6e62a49a-fdb1-a087-fe83-e86aed969ae7@codeaurora.org>
User-Agent: alot/0.8
To:     Jeffrey Hugo <jhugo@codeaurora.org>, bjorn.andersson@linaro.org,
        mturquette@baylibre.com
In-Reply-To: <6e62a49a-fdb1-a087-fe83-e86aed969ae7@codeaurora.org>
Date:   Tue, 05 Feb 2019 14:32:01 -0800
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Jeffrey Hugo (2019-02-05 14:15:16)
> On 2/5/2019 3:01 PM, Stephen Boyd wrote:
> > Quoting Jeffrey Hugo (2019-01-30 08:35:44)
> >> The XO clock generally feeds into other clock controllers as the parent
> >> for a lot of clock generators.
> >>
> >> Fixes: 6131dc81211c (clk: qcom: smd: Add support for MSM8998 rpm clock=
s)
> >> Signed-off-by: Jeffrey Hugo <jhugo@codeaurora.org>
> >=20
> > We've historically left out the XO clk because it causes problems where
> > the XO vote goes away during late init because nobody references it from
> > the rest of the clk tree and also because RPM defers probe of the system
> > and then the console blows up when it gets a clk that can't change rate.
> > See commit 54823af9cd52 ("clk: qcom: Always add factor clock for xo
> > clocks") for some more info on why we removed all the workarounds and
> > stuff around here too.
> >=20
> > So are you sure this is OK to do?
> >  =20
> >=20
>=20
> So, I've got pretty much everything as modules, and I haven't seen any=20
> issues.  However let me take a look at the commit you point out and see.
>=20

Is the name of the clk "xo_clk_src"? That isn't the name that we were
expecting the XO clk from RPM to be called. You might have to look back
at the history of the rpm clk driver on the list and see when Georgi
dropped the XO clk from it and if there was anything wrong with that. I
can't recall if this was discussed on the list or if he just told me in
some hallway conversation at Connect.

