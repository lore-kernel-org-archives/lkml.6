Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934046AbeCGQMl (ORCPT <rfc822;w@1wt.eu>);
        Wed, 7 Mar 2018 11:12:41 -0500
Received: from mx0b-001ae601.pphosted.com ([67.231.152.168]:53740 "EHLO
        mx0b-001ae601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S933848AbeCGQMa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Mar 2018 11:12:30 -0500
Authentication-Results: ppops.net;
        spf=none smtp.mailfrom=ckeepax@opensource.cirrus.com
Date: Wed, 7 Mar 2018 16:12:26 +0000
From: Charles Keepax <ckeepax@opensource.cirrus.com>
To: Linus Walleij <linus.walleij@linaro.org>
CC: Richard Fitzgerald <rf@opensource.cirrus.com>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        <patches@opensource.cirrus.com>
Subject: Re: [PATCH] pinctrl: devicetree: Fix dt_to_map_one_config handling
 of hogs
Message-ID: <20180307161226.vweofwcvy6nvux5p@localhost.localdomain>
References: <20180228155306.1006-1-rf@opensource.cirrus.com>
 <CACRpkdYc1Ovvhwze37-uJJL+5YG5kHuW9rgDSbfhxLRP30aPWg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <CACRpkdYc1Ovvhwze37-uJJL+5YG5kHuW9rgDSbfhxLRP30aPWg@mail.gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1711220000
 definitions=main-1803070187
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 02, 2018 at 09:42:54AM +0100, Linus Walleij wrote:
> On Wed, Feb 28, 2018 at 4:53 PM, Richard Fitzgerald
> <rf@opensource.cirrus.com> wrote:
> 
> > When dt_to_map_one_config() is called with a pinctrl_dev passed
> > in, it should only be using this if the node being looked up
> > is a hog. The code was always using the passed pinctrl_dev
> > without checking whether the dt node referred to it.
> >
> > A pin controller can have pinctrl-n dependencies on other pin
> > controllers in these cases:
> >
> > - the pin controller hardware is external, for example I2C, so
> >   needs other pin controller(s) to be setup to communicate with
> >   the hardware device.
> >
> > - it is a child of a composite MFD so its of_node is shared with
> >   the parent MFD and other children of that MFD. Any part of that
> >   MFD could have dependencies on other pin controllers.
> >
> > Because of this, dt_to_map_one_config() can't assume that if it
> > has a pinctrl_dev passed in then the node it looks up must be
> > a hog. It could be a reference to some other pin controller.
> >
> > Signed-off-by: Richard Fitzgerald <rf@opensource.cirrus.com>
> 
> Seems correct. Also the code is a little more clear
> after the patch.
> 
> Patch applied.
> 
> It'd be nice to see some testing of this, I hope linux-next is a good
> testing ground.
> 

Once we are happy on the testing front, how would you feel about
getting this forwarded to 4.14 stable as well?

The trouble is for our customers on 4.14 this bug would cause
us to have to change the layout of the device tree bindings. We
end up having to make a subnode for the pinctrl and move the
hogs into there, keeping the main pin settings on the MFD device
itself. And we know from the Madera series that such a DT
arrangement is not acceptable upstream. Meaning without this
patch on 4.14 our customers are forced to have DT bindings that
won't be compatible with a mainline kernel.

Thanks,
Charles
