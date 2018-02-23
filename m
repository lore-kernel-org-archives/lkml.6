Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751424AbeBWDUs (ORCPT <rfc822;w@1wt.eu>);
        Thu, 22 Feb 2018 22:20:48 -0500
Received: from mail-pl0-f68.google.com ([209.85.160.68]:45472 "EHLO
        mail-pl0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751274AbeBWDUq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Feb 2018 22:20:46 -0500
X-Google-Smtp-Source: AH8x227X91kclWqf5Vh3xKtx1PjJN4PbjzblhhFq32lLOeSly4NbPHPeJRhrmdRgtWrt+z4eV/ZgNA==
Subject: Re: [PATCH v4 00/16] R-Car DU: Convert LVDS code to bridge driver
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>,
        dri-devel@lists.freedesktop.org, linux-renesas-soc@vger.kernel.org,
        Rob Herring <robh@kernel.org>, Matt Porter <mporter@konsulko.com>,
        Koen Kooi <koen@dominion.thruhere.net>,
        Guenter Roeck <linux@roeck-us.net>, Marek Vasut <marex@denx.de>,
        Wolfram Sang <wsa@the-dreams.de>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org,
        Pantelis Antoniou <pantelis.antoniou@konsulko.com>
References: <20180220231046.32638-1-laurent.pinchart+renesas@ideasonboard.com>
 <d6b14861-68c9-eacb-469a-219745badb9f@gmail.com> <6129743.3Euq8y3YuW@avalon>
From: Frank Rowand <frowand.list@gmail.com>
Message-ID: <050fa0bb-2157-8796-1bce-354f1da67e24@gmail.com>
Date: Thu, 22 Feb 2018 19:20:43 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <6129743.3Euq8y3YuW@avalon>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Laurent,

On 02/22/18 02:25, Laurent Pinchart wrote:
> Hi Frank,
> 
> On Thursday, 22 February 2018 08:07:14 EET Frank Rowand wrote:
>> On 02/20/18 15:10, Laurent Pinchart wrote:
>>> Hello,
>>>
>>> This patch series addresses a design mistake that dates back from the
>>> initial DU support. Support for the LVDS encoders, which are IP cores
>>> separate from the DU, was bundled in the DU driver. Worse, both the DU
>>> and LVDS were described through a single DT node.
>>>
>>> To fix the, patches 01/16 and 02/16 define new DT bindings for the LVDS
>>> encoders, and deprecate their description inside the DU bindings. To
>>> retain backward compatibility with existing DT, patches 03/16 to 08/16
>>> then patch the device tree at runtime to convert the legacy bindings to
>>> the new ones.
>>>
>>> With the DT side addressed, patch 09/16 converts the LVDS support code to
>>> a separate bridge driver. Patches 11/16 to 16/16 then update all the
>>> device tree sources to the new DU and LVDS encoders bindings.
>>>
>>> I decided to go for live DT patching in patch 08/16 because implementing
>>> support for both the legacy and new bindings in the driver would have been
>>> very intrusive, and prevented further cleanups. This version relies more
>>> heavily on overlays to avoid touching the internals of the OF core
>>> compared to v2, even if manual fixes to the device tree are still needed.
>>>
>>> Compared to v3, this series uses the OF changeset API to update properties
>>> instead of accessing the internals of the property structure. This removes
>>> the local implementation of functions to look up nodes by path and update
>>> properties. In order to do this, I pulled in Pantelis' patch series
>>> titled "[PATCH v2 0/5] of: dynamic: Changesets helpers & fixes" at Rob's
>>> request, and rebased it while taking two small review comments into
>>> account.
>>
>> Wait a minute!  Why are you putting a patch set to modify core devicetree
>> in the middle of a driver series.  Please pull it out to a separate series.
> 
> Because Rob asked for the driver-local implementation of the property add 
> function to be replaced by Pantelis' series. I want to get the LVDS changes in 
> v4.17 and asked Rob whether I could then take the OF changeset patches merged 
> through the DRM tree, and he didn't object. If that causes an issue I'll 
> switch back to the driver-local implementation to get the driver changes 
> merged, split the OF changeset series out, and then move to the OF changeset 
> API once merged. Would you prefer that ?

You have already created a new version of the R-Car patches without the
set of patches that I was objecting to here.  So this is somewhat just
an academic comment.

As I mentioned in the v6 thread, I am coming back here to clean up loose
ends, and explain why I had the reaction I had.  Basically, this is a
process issue to me.

(1) The patch set from Pantelis is "hidden" in the driver patch series.
When viewing collapsed threads (which is my normal mode to avoid getting
overwhelmed by the vast volume of email I scan), the Pantelis patch set
is totally invisible.  If the R-Car driver patch series had not had me
on the to: list, there is a very good chance I would not have noticed
it.  Or noticed in a more delayed time frame.  And the same applies to
anyone else who might be subscribed to the devicetree mail list.  If
the Pantelis patch series was split out into a separate patch set then
it would be more visible on the list.

(2) There is no good way to indicate in the email subject lines for
the Pantelis patches that they are version 3 of the series, since
they are also version 4 of the R-Car patch series.  If one reads the
patch 0/0 header carefully, and/or the other Pantelis patch comment
headers carefully, and then does a little detective work, it is
possible to find version 2 of the Pantelis patch series, and thus
be able to track the full history.  If just glancing at each
individual patch email subject, scanning the patch comment, and
spending more time reading the body of the patch, it would be
very easy to overlook the existence of the previous versions on
the mail list.

(2b) Small quibble:  if the Pantelis patches were in a separate series,
with v3 in the subject header, then you would have normally put
a "changes since v2" section in the patch comment header, which would
have been more visible and less cryptic than what you wrote, which was:

   ...

   Signed-off-by: Pantelis Antoniou <pantelis.antoniou@konsulko.com>
   [Fixed memory leak in __of_changeset_add_update_property_copy()]
   Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
   ---
    drivers/of/dynamic.c | 222 ++++++++++++++++++++++++++++++++++
    include/linux/of.h   | 328 +++++++++++++++++++++++++++++++++++++++++++++++++++
    2 files changed, 550 insertions(+)

My original scan of version 2 and then the email in this series had me
questioning whether the two open issues from patch 2 had been addressed
(yes, patch 0/16 did explicitly mention that 2 review comments had been
taken into account, so you can point at my poor reading comprehension).

(3) This is totally unrelated to your patch series, but I'm leaving a bread
crumb trail here.  Rob pointed you at a patch series that was not the most
recent version.  When this patch series appears again, there already is
a version 3 subset of it, but it is still labeled as being version 2, and
also has outstanding un-addressed issues.  ("[PATCH v2 1/2] of: dynamic:
Add __of_node_dupv()", 11/04/16)

-Frank
