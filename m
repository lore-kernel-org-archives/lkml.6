Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754464AbeCGRxN (ORCPT <rfc822;w@1wt.eu>);
        Wed, 7 Mar 2018 12:53:13 -0500
Received: from mx0b-001ae601.pphosted.com ([67.231.152.168]:34140 "EHLO
        mx0b-001ae601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751284AbeCGRxL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Mar 2018 12:53:11 -0500
Authentication-Results: ppops.net;
        spf=none smtp.mailfrom=ckeepax@opensource.cirrus.com
Date: Wed, 7 Mar 2018 17:53:03 +0000
From: Charles Keepax <ckeepax@opensource.cirrus.com>
To: Lee Jones <lee.jones@linaro.org>
CC: <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <linus.walleij@linaro.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <patches@opensource.cirrus.com>
Subject: Re: [PATCH v3 1/2] mfd: arizona: Update reset pin to use GPIOD
Message-ID: <20180307175303.bl5qgn6tjzka5byf@localhost.localdomain>
References: <20180220163540.6704-1-ckeepax@opensource.cirrus.com>
 <20180307132812.r5epcs26clpnh72t@dell>
 <20180307141509.e3dpxteodxeoy2k3@localhost.localdomain>
 <20180307162537.pryp3qz3lgm7a4zs@dell>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20180307162537.pryp3qz3lgm7a4zs@dell>
User-Agent: NeoMutt/20170113 (1.7.2)
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1711220000
 definitions=main-1803070204
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 07, 2018 at 04:25:37PM +0000, Lee Jones wrote:
> On Wed, 07 Mar 2018, Charles Keepax wrote:
> 
> > On Wed, Mar 07, 2018 at 01:28:12PM +0000, Lee Jones wrote:
> > > On Tue, 20 Feb 2018, Charles Keepax wrote:
> > I would guess most of the time yes, but I would rather not assume
> > that. I can redo this as if's if you prefer it that way? The if is
> > slightly less lines although I do think the switch is much
> > clearer as to intent.
> > 
> > if (ret == -EPROBE_DEFER) {
> > 	return ret;
> > } else if (ret != -ENOENT && ret != -ENOSYS {
> > 	dev_err(arizona->dev, ....);
> > }
> 
> I don't know enough about the API to see why -ENOENT and -ENOSYS do
> not deserve error messages.
> 

ENOENT means the property was not found, and ENOSYS means that
there is no GPIOLIB built into the kernel.

In hindsight really I think this did deserve a comment. Basically
what is going on here, is we are supporting both the old and the
new binding, this is the code that looks for the old binding. If
we don't find anything then we don't want to print a message now
because we will print a message when we later check for the newer
binding. However if the binding is present but somehow invalid
then we would like to print the error. The newer binding read
later won't detect if the older binding is present and corrupt.

> What do the other users of the API do?
> 

Alas this looks like one of the first users.

Thanks,
Charles
