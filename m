Return-Path: <SRS0=sczE=Q3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 813DBC4360F
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 14:01:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 526BE20880
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 14:01:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726688AbfBTOBK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Feb 2019 09:01:10 -0500
Received: from mo4-p02-ob.smtp.rzone.de ([81.169.146.171]:34790 "EHLO
        mo4-p02-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726557AbfBTOBI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Feb 2019 09:01:08 -0500
X-RZG-AUTH: ":JGIXVUS7cutRB/49FwqZ7WcJeFKiMhflhwDubTJ9o1OAA2UNf2M0OzzrKQ=="
X-RZG-CLASS-ID: mo00
Received: from iMac.fritz.box
        by smtp.strato.de (RZmta 44.9 DYNA|AUTH)
        with ESMTPSA id 608499v1KE0wEqT
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (curve secp521r1 with 521 ECDH bits, eq. 15360 bits RSA))
        (Client did not present a certificate);
        Wed, 20 Feb 2019 15:00:58 +0100 (CET)
From:   "H. Nikolaus Schaller" <hns@goldelico.com>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "H. Nikolaus Schaller" <hns@goldelico.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Charles Keepax <ckeepax@opensource.cirrus.com>,
        Song Qiang <songqiang1304521@gmail.com>
Cc:     letux-kernel@openphoenux.org, Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Gregor Boirie <gregor.boirie@parrot.com>,
        Sebastian Reichel <sre@kernel.org>,
        Samu Onkalo <samu.onkalo@intel.com>
Subject: [PATCH 1/9] iio: document bindings for mounting matrices
Date:   Wed, 20 Feb 2019 15:00:48 +0100
Message-Id: <a1fcef308d9193cac33cda2420b6df5000cfc9c7.1550671256.git.hns@goldelico.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <cover.1550671256.git.hns@goldelico.com>
References: <cover.1550671256.git.hns@goldelico.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Linus Walleij <linus.walleij@linaro.org>

The mounting matrix for sensors was introduced in
commit dfc57732ad38 ("iio:core: mounting matrix support")

However the device tree bindings are very terse and since this is
a widely applicable property, we need a proper binding for it
that the other bindings can reference. This will also be useful
for other operating systems and sensor engineering at large.

I think all 3D sensors should support it, the current situation
is probably that the mounting information is confined in magic
userspace components rather than using the mounting matrix, which
is not good for portability and reuse.

Cc: Gregor Boirie <gregor.boirie@parrot.com>
Cc: Sebastian Reichel <sre@kernel.org>
Cc: Samu Onkalo <samu.onkalo@intel.com>
Cc: devicetree@vger.kernel.org
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 .../devicetree/bindings/iio/mount-matrix.txt  | 108 ++++++++++++++++++
 1 file changed, 108 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/mount-matrix.txt

diff --git a/Documentation/devicetree/bindings/iio/mount-matrix.txt b/Documentation/devicetree/bindings/iio/mount-matrix.txt
new file mode 100644
index 000000000000..a3714727f739
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/mount-matrix.txt
@@ -0,0 +1,108 @@
+Mounting matrix
+
+The mounting matrix is a device tree property used to orient any IIO device
+that produce three-dimensional data in relation to the world where it is
+deployed.
+
+The purpose of the mounting matrix is to translate the sensor frame of
+reference into the device frame of reference using a translation matrix as
+defined in linear algebra.
+
+The typical usecase is that where a component has an internal representation
+of the (x,y,z) triplets, such as different registers to read these coordinates,
+and thus implying that the component should be mounted in a certain orientation
+relative to some specific device frame of reference.
+
+For example a device with some kind of screen, where the user is supposed to
+interact with the environment using an accelerometer, gyroscope or magnetometer
+mounted on the same chassis as this screen, will likely take the screen as
+reference to (x,y,z) orientation, with (x,y) corresponding to these axes on the
+screen and (z) being depth, the axis perpendicular to the screen.
+
+For a screen you probably want (x) coordinates to go from negative on the left
+to positive on the right and (z) depth to be negative under the screen and
+positive in front of it, toward the face of the user.
+
+A sensor can be mounted in any angle along the axes relative to the frame of
+reference. This means that the sensor may be flipped upside-down, left-right,
+or tilted at any angle relative to the frame of reference.
+
+Another frame of reference is how the device with its sensor relates to the
+external world, the environment where the device is deployed. Usually the data
+from the sensor is used to figure out how the device is oriented with respect
+to this world. When using the mounting matrix, the sensor and device orientation
+becomes identical and we can focus on the data as it relates to the surrounding
+world.
+
+Device-to-world examples for some three-dimensional sensor types:
+
+- Accelerometers have their world frame of reference toward the center of
+  gravity, usually to the core of the planet. A reading of the (x,y,z) values
+  from the sensor will give a projection of the gravity vector through the
+  device relative to the center of the planet, i.e. relative to its surface at
+  this point. Up and down in the world relative to the device frame of
+  reference can thus be determined. and users would likely expect a value of
+  9.81 m/s^2 upwards along the (z) axis, i.e. out of the screen when the device
+  is held with its screen flat on the planets surface and 0 on the other axes,
+  as the gravity vector is projected 1:1 onto the sensors (z)-axis.
+
+- Magnetometers (compasses) have their world frame of reference relative to the
+  geomagnetic field. The system orientation vis-a-vis the world is defined with
+  respect to the local earth geomagnetic reference frame where (y) is in the
+  ground plane and positive towards magnetic North, (x) is in the ground plane,
+  perpendicular to the North axis and positive towards the East and (z) is
+  perpendicular to the ground plane and positive upwards.
+
+- Gyroscopes detects the movement relative the device itself. The angular
+  velocity is defined as orthogonal to the plane of rotation, so if you put the
+  device on a flat surface and spin it around the z axis (such as rotating a
+  device with a screen lying flat on a table), you should get a negative value
+  along the (z) axis if rotated clockwise, and a positive value if rotated
+  counter-clockwise according to the right-hand rule.
+
+So unless the sensor is ideally mounted, we need a means to indicate the
+relative orientation of any given sensor of this type with respect to the
+frame of reference.
+
+To achieve this, use the device tree property "mount-matrix" for the sensor.
+This supplies a 3x3 rotation matrix in the strict linear algebraic sense,
+to orient the senor axes relative to a desired point of reference. This means
+the resulting values from the sensor, after scaling to proper units, should be
+multiplied by this matrix to give the proper vectors values in three-dimensional
+space, relative to the device or world point of reference.
+
+For more information, consult:
+https://en.wikipedia.org/wiki/Rotation_matrix
+
+The mounting matrix has the layout:
+
+ (x0, y0, z0)
+ (x1, y1, z1)
+ (x2, y2, z3)
+
+And it is represented as an array of strings containing the real values for
+producing the transformation matrix. The real values use a decimal point and
+a minus (-) to indicate a negative value.
+
+Examples:
+
+Identity matrix (nothing happens to the coordinates, which means the device was
+mechanically mounted in an ideal way and we need no transformation):
+
+mount-matrix = "1", "0", "0",
+               "0", "1", "0",
+               "0", "0", "1";
+
+The sensor is mounted 30 degrees (Pi/6 radians) tilted along the X axis, so we
+compensate by performing a -30 degrees rotation around the X axis:
+
+mount-matrix = "1", "0", "0",
+               "0", "0.866", "0.5",
+               "0", "-0.5", "0.866";
+
+The sensor is flipped 180 degrees (Pi radians) around the Z axis, i.e. mounted
+upside-down:
+
+mount-matrix = "0.998", "0.054", "0",
+               "-0.054", "0.998", "0",
+               "0", "0", "1";
-- 
2.19.1

