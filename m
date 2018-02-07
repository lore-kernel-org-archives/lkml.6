Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754674AbeBGTGi (ORCPT <rfc822;w@1wt.eu>);
        Wed, 7 Feb 2018 14:06:38 -0500
Received: from mail-yw0-f193.google.com ([209.85.161.193]:35018 "EHLO
        mail-yw0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754505AbeBGTGg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Feb 2018 14:06:36 -0500
X-Google-Smtp-Source: AH8x226GRw92qYVYtXBuncArxj/sSKcfwKgjRXV/Qy5rnH6HjsPCyKYntdazKfAkGjs00d27ldpYuDQK0+TjLTwGal8=
MIME-Version: 1.0
In-Reply-To: <CABXOdTefUzvLFd-QeQ_NBBwxiAD+AfoKhdJp_vmeBx8WULaf-A@mail.gmail.com>
References: <20180207185843.75983-1-mka@chromium.org> <CABXOdTefUzvLFd-QeQ_NBBwxiAD+AfoKhdJp_vmeBx8WULaf-A@mail.gmail.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 7 Feb 2018 14:06:35 -0500
Message-ID: <CADnq5_M2V4iViiOCOnseFgSiMA9+JZq68gxtEeRk+HkAKr9c+w@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/powerplay: Fix enum mismatch
To: Guenter Roeck <groeck@google.com>
Cc: Matthias Kaehlcke <mka@chromium.org>, David Zhou <David1.Zhou@amd.com>,
        Craig Bergstrom <craigb@chromium.org>,
        Justin TerAvest <teravest@chromium.org>,
        David Airlie <airlied@linux.ie>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        Guenter Roeck <groeck@chromium.org>,
        Maling list - DRI developers
        <dri-devel@lists.freedesktop.org>,
        Alex Deucher <alexander.deucher@amd.com>, Rex Zhu <Rex.Zhu@amd.com>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 7, 2018 at 2:01 PM, Guenter Roeck <groeck@google.com> wrote:
> On Wed, Feb 7, 2018 at 10:58 AM, Matthias Kaehlcke <mka@chromium.org> wrote:
>> In several locations the driver uses AMD_CG_STATE_UNGATE (type enum
>> amd_clockgating_state) instead of AMD_PG_STATE_UNGATE (type enum
>> amd_powergating_stat) and vice versa. Both constants have the same
>> value, so this doesn't cause any problems, but we still want to pass
>> the correct type.
>>
>> Fixing the mismatch resolves multiple warnings like this when building
>> with clang:
>>
>> drivers/gpu/drm/amd/amdgpu/../powerplay/hwmgr/cz_clockpowergating.c:169:7:
>>   error: implicit conversion from enumeration type 'enum
>>   amd_powergating_state' to different enumeration type 'enum
>>   amd_clockgating_state' [-Werror,-Wenum-conversion]
>>     AMD_PG_STATE_UNGATE);
>>
>> Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
>
> Reviewed-by: Guenter Roeck <groeck@chromium.org>

Applied.  thanks!

Alex

>
>> ---
>>  drivers/gpu/drm/amd/powerplay/hwmgr/cz_clockpowergating.c   | 8 ++++----
>>  drivers/gpu/drm/amd/powerplay/hwmgr/smu7_clockpowergating.c | 2 +-
>>  2 files changed, 5 insertions(+), 5 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/powerplay/hwmgr/cz_clockpowergating.c b/drivers/gpu/drm/amd/powerplay/hwmgr/cz_clockpowergating.c
>> index 44de0874629f..416abebb8b86 100644
>> --- a/drivers/gpu/drm/amd/powerplay/hwmgr/cz_clockpowergating.c
>> +++ b/drivers/gpu/drm/amd/powerplay/hwmgr/cz_clockpowergating.c
>> @@ -166,10 +166,10 @@ void cz_dpm_powergate_uvd(struct pp_hwmgr *hwmgr, bool bgate)
>>                 cz_dpm_powerup_uvd(hwmgr);
>>                 cgs_set_clockgating_state(hwmgr->device,
>>                                                 AMD_IP_BLOCK_TYPE_UVD,
>> -                                               AMD_PG_STATE_UNGATE);
>> +                                               AMD_CG_STATE_UNGATE);
>>                 cgs_set_powergating_state(hwmgr->device,
>>                                                 AMD_IP_BLOCK_TYPE_UVD,
>> -                                               AMD_CG_STATE_UNGATE);
>> +                                               AMD_PG_STATE_UNGATE);
>>                 cz_dpm_update_uvd_dpm(hwmgr, false);
>>         }
>>
>> @@ -197,11 +197,11 @@ void cz_dpm_powergate_vce(struct pp_hwmgr *hwmgr, bool bgate)
>>                 cgs_set_clockgating_state(
>>                                         hwmgr->device,
>>                                         AMD_IP_BLOCK_TYPE_VCE,
>> -                                       AMD_PG_STATE_UNGATE);
>> +                                       AMD_CG_STATE_UNGATE);
>>                 cgs_set_powergating_state(
>>                                         hwmgr->device,
>>                                         AMD_IP_BLOCK_TYPE_VCE,
>> -                                       AMD_CG_STATE_UNGATE);
>> +                                       AMD_PG_STATE_UNGATE);
>>                 cz_dpm_update_vce_dpm(hwmgr);
>>                 cz_enable_disable_vce_dpm(hwmgr, true);
>>         }
>> diff --git a/drivers/gpu/drm/amd/powerplay/hwmgr/smu7_clockpowergating.c b/drivers/gpu/drm/amd/powerplay/hwmgr/smu7_clockpowergating.c
>> index 69a0678ace98..402aa9cb1f78 100644
>> --- a/drivers/gpu/drm/amd/powerplay/hwmgr/smu7_clockpowergating.c
>> +++ b/drivers/gpu/drm/amd/powerplay/hwmgr/smu7_clockpowergating.c
>> @@ -162,7 +162,7 @@ void smu7_powergate_uvd(struct pp_hwmgr *hwmgr, bool bgate)
>>                                 AMD_CG_STATE_UNGATE);
>>                 cgs_set_powergating_state(hwmgr->device,
>>                                                 AMD_IP_BLOCK_TYPE_UVD,
>> -                                               AMD_CG_STATE_UNGATE);
>> +                                               AMD_PG_STATE_UNGATE);
>>                 smu7_update_uvd_dpm(hwmgr, false);
>>         }
>>
>> --
>> 2.16.0.rc1.238.g530d649a79-goog
>>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
